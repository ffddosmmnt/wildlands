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


func _ready() -> void:
	reload()


func reload() -> void:
	_entities.clear()
	_recipes.clear()
	_skills.clear()
	_scan_dir(DATA_ROOT)
	print("[Database] indexed %d entities, %d recipes, %d skills" % [
		_entities.size(), _recipes.size(), _skills.size()])


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
	var result: Array[GameEntity] = []
	for e in _entities.values():
		if e.type == type:
			result.append(e)
	return result


func all_recipes() -> Array:
	return _recipes.values()


func all_skills() -> Array:
	return _skills.values()
