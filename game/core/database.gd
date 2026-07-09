extends Node

## Autoload singleton. The single source of content lookups.
## On startup it recursively scans res://data for .tres definitions and
## indexes them by id. No gameplay system hardcodes content — everything
## comes from here, so adding content is purely a matter of dropping in a
## new .tres file.

const DATA_ROOT := "res://data"

var _entities: Dictionary = {}   # id -> GameEntity (materials, items, resources, creatures)
var _recipes: Dictionary = {}    # id -> RecipeDef
var _skills: Dictionary = {}     # id -> SkillDef
var _by_type: Dictionary = {}    # type -> Array[GameEntity], built once at load


func _ready() -> void:
	reload()


func reload() -> void:
	_entities.clear()
	_recipes.clear()
	_skills.clear()
	_by_type.clear()
	_scan_dir(DATA_ROOT)
	_build_type_index()
	print("[Database] indexed %d entities, %d recipes, %d skills" % [
		_entities.size(), _recipes.size(), _skills.size()])
	var errors := validate()
	if errors.is_empty():
		print("[Database] validation: OK")
	else:
		push_warning("[Database] validation: %d issue(s)" % errors.size())
		for e in errors:
			push_warning("  - " + e)


func _build_type_index() -> void:
	for e in _entities.values():
		if not _by_type.has(e.type):
			_by_type[e.type] = []
		_by_type[e.type].append(e)


func _scan_dir(path: String) -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		push_warning("[Database] cannot open %s" % path)
		return
	dir.list_dir_begin()
	var name := dir.get_next()
	while name != "":
		var full := path.path_join(name)
		if dir.current_is_dir():
			if not name.begins_with("."):
				_scan_dir(full)
		elif name.ends_with(".tres") or name.ends_with(".res"):
			_index_resource(full)
		name = dir.get_next()
	dir.list_dir_end()


func _index_resource(res_path: String) -> void:
	var res := load(res_path)
	if res == null:
		push_warning("[Database] failed to load %s" % res_path)
		return
	if res is RecipeDef:
		_register(_recipes, res.id, res, res_path)
	elif res is SkillDef:
		_register(_skills, res.id, res, res_path)
	elif res is GameEntity:
		_register(_entities, res.id, res, res_path)
	# Other resource types under /data are ignored on purpose.


func _register(table: Dictionary, id: String, res: Resource, res_path: String) -> void:
	if id == "":
		push_warning("[Database] resource with empty id: %s" % res_path)
		return
	if table.has(id):
		push_warning("[Database] duplicate id '%s' (%s)" % [id, res_path])
	table[id] = res


# --- Public API ---

func get_entity(id: String) -> GameEntity:
	return _entities.get(id)


func get_material(id: String) -> MaterialDef:
	var e := get_entity(id)
	return e if e is MaterialDef else null


func get_recipe(id: String) -> RecipeDef:
	return _recipes.get(id)


func get_skill(id: String) -> SkillDef:
	return _skills.get(id)


func all_of_type(type: String) -> Array[GameEntity]:
	# O(1) lookup via the load-time index; returns a copy so callers can't
	# mutate the index. Scales to 1000 items / 100 creatures.
	var result: Array[GameEntity] = []
	result.assign(_by_type.get(type, []))
	return result


func all_recipes() -> Array:
	return _recipes.values()


func all_skills() -> Array:
	return _skills.values()


# --- Validation ---
# Runs once at load. Catches authoring bugs (bad references, formula property
# typos) up front instead of at craft/gather time. Returns a list of messages.

func validate() -> Array[String]:
	var errors: Array[String] = []

	for recipe in _recipes.values():
		if not _entities.has(recipe.output_type):
			errors.append("recipe '%s': output_type '%s' not found" % [recipe.id, recipe.output_type])
		if recipe.skill_id != "" and not _skills.has(recipe.skill_id):
			errors.append("recipe '%s': skill_id '%s' not found" % [recipe.id, recipe.skill_id])
		var slot_tags: Dictionary = {}   # slot_id -> accepts_tag
		for slot in recipe.slots:
			var sid: String = slot.get("slot_id", "")
			var tag: String = slot.get("accepts_tag", "")
			if sid == "":
				errors.append("recipe '%s': a slot is missing slot_id" % recipe.id)
			if tag == "":
				errors.append("recipe '%s': slot '%s' has empty accepts_tag" % [recipe.id, sid])
			slot_tags[sid] = tag
		# Formula property references: `tip.sharpness` must be a real property
		# some accepted material provides (else it silently evaluates to 0).
		for stat in recipe.stat_formulas:
			for ref in _formula_refs(recipe.stat_formulas[stat]):
				var sid: String = ref[0]
				var prop: String = ref[1]
				if not slot_tags.has(sid):
					errors.append("recipe '%s' formula '%s': unknown slot '%s'" % [recipe.id, stat, sid])
				elif not _tag_provides(slot_tags[sid], prop):
					errors.append("recipe '%s' formula '%s': no '%s' material provides '%s'" % [
						recipe.id, stat, slot_tags[sid], prop])

	for e in _entities.values():
		for entry in e.get_property("drop_table", []):
			var mid: String = entry.get("material", "")
			if not _entities.has(mid):
				errors.append("resource '%s': drop_table material '%s' not found" % [e.id, mid])

	return errors


## Extracts `slot.property` references from a formula string as [[slot, prop], ...].
func _formula_refs(formula: String) -> Array:
	var re := RegEx.new()
	re.compile("([A-Za-z_]\\w*)\\.([A-Za-z_]\\w*)")
	var out: Array = []
	for m in re.search_all(formula):
		out.append([m.get_string(1), m.get_string(2)])
	return out


## True if some material with `tag` exposes `prop`. `quality` is rolled at
## gather time (not on the template), so it always counts as provided.
func _tag_provides(tag: String, prop: String) -> bool:
	if prop == "quality":
		return true
	for e in _entities.values():
		if e is MaterialDef and e.has_tag(tag) and e.resolved_properties().has(prop):
			return true
	return false
