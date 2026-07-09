class_name Player
extends CharacterBody3D

## The playable character. Pure presentation + input glue — every gameplay
## decision routes into existing systems (GatheringSystem, CraftingSystem,
## CombatSystem, LootSystem via CreatureInstance, SkillSystem). Holds an
## Inventory and a CombatEntity; owns nothing rule-wise.

const SPEED := 6.0
const ISO_YAW := 45.0            # ponytail: matches the camera yaw; tune together
const INTERACT_RANGE := 2.8
const HEALTH_REGEN := 3.0        # per second; keeps a fight survivable, not trivial

var inventory := Inventory.new()
var combat: CombatEntity
var _interactor: Interactor
var _hud: Label
var _msg := "Arrows: move   E: gather / attack   C: craft & equip spear"
var _spawn_pos: Vector3


func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING   # top-down plane movement, no gravity/floor
	add_to_group("player")
	combat = CombatEntity.from_stats({
		"name": "Player", "health": 100, "stamina": 100, "attack": 5, "defense": 3})
	_spawn_pos = global_position
	_build_body()
	_build_camera()
	_build_hud()
	_interactor = Interactor.new()
	add_child(_interactor)


func _physics_process(delta: float) -> void:
	var input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector3(input.x, 0.0, input.y).rotated(Vector3.UP, deg_to_rad(ISO_YAW)) * SPEED
	move_and_slide()
	combat.regen_stamina(delta)
	combat.health = minf(combat.max_health, combat.health + HEALTH_REGEN * delta)
	if combat.health <= 0.0:
		_respawn()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_E: _interact()
			KEY_C: _craft_spear()


func _process(_delta: float) -> void:
	_update_hud()


# --- Interaction routes into existing systems ---

func _interact() -> void:
	var target := _interactor.nearest(global_position, INTERACT_RANGE)
	if target == null:
		_msg = "Nothing in range"
	elif target is ResourceNode:
		_gather(target)
	elif target is CreatureNode:
		_attack(target)


func _gather(node: ResourceNode) -> void:
	if node.is_depleted():
		_msg = "%s is depleted" % node.resource_id
		return
	var drops := GatheringSystem.gather(node, 0.0)
	for d in drops:
		inventory.add(d)
	_msg = "Gathered %d from %s" % [drops.size(), node.resource_id]
	if node.is_depleted():
		node.visible = false


func _attack(cnode: CreatureNode) -> void:
	if cnode.creature == null or not cnode.creature.is_alive():
		return
	var res := CombatSystem.attack(combat, cnode.creature.combat, global_position.distance_to(cnode.global_position))
	match res.reason:
		"out_of_range": _msg = "Too far — close in with the spear"
		"no_stamina": _msg = "Too tired to attack — wait for stamina"
		"broken": _msg = "Your weapon is broken"
		_: _msg = "Hit %s for %.0f" % [cnode.creature.def.display_name, res.damage]
	if res.target_killed:
		var loot: Array = cnode.creature.generate_loot(SkillSystem.get_bonus("hunting"), _tool_quality())
		for l in loot:
			inventory.add(l)
		_msg = "Killed %s — looted %d material(s)!" % [cnode.creature.def.display_name, loot.size()]
		cnode.queue_free()


func _craft_spear() -> void:
	var recipe := Database.get_recipe("recipe_spear")
	var tip := _best(inventory.query_by_tag("sharp_material"), "sharpness")
	var handle := _best(inventory.query_by_tag("handle_material"), "hardness")
	if tip == null or handle == null:
		_msg = "Need a sharp material + a handle material (gather stone & wood)"
		return
	var res := CraftingSystem.craft(recipe, {"tip": tip, "handle": handle}, SkillSystem.get_bonus("crafting"))
	if not res.success:
		_msg = "Craft failed: %s" % res.error
		return
	inventory.remove(tip)      # consume inputs
	inventory.remove(handle)
	inventory.add(res.item)
	combat.equip(res.item)     # auto-equip the fresh spear
	_msg = "Crafted & equipped spear (dmg %.0f)" % res.item.get_stat("damage")


func _tool_quality() -> float:
	return combat.equipped_weapon.get_stat("damage") if combat.equipped_weapon != null else 0.0


## Highest-`stat` instance in a list (best tip/handle available) — makes the
## looted predator bone auto-upgrade the next spear.
func _best(list: Array, stat: String) -> ItemInstance:
	var best: ItemInstance = null
	var best_v := -1.0
	for it in list:
		var v: float = it.get_stat(stat)
		if v > best_v:
			best_v = v
			best = it
	return best


func _respawn() -> void:
	combat.health = combat.max_health
	combat.stamina = combat.max_stamina
	global_position = _spawn_pos
	_msg = "Knocked out — recovered at camp"


# --- Placeholder presentation (not final UI/assets) ---

func _build_body() -> void:
	var mesh := MeshInstance3D.new()
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.4
	capsule.height = 1.6
	mesh.mesh = capsule
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.25, 0.5, 0.95)
	mesh.material_override = mat
	mesh.position.y = 0.8
	add_child(mesh)
	var col := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.4
	shape.height = 1.6
	col.shape = shape
	col.position.y = 0.8
	add_child(col)


func _build_camera() -> void:
	var cam := Camera3D.new()
	cam.projection = Camera3D.PROJECTION_ORTHOGONAL
	cam.size = 18.0
	cam.position = Vector3(16, 20, 16)   # fixed iso offset, follows via parenting
	add_child(cam)
	cam.look_at(global_position, Vector3.UP)


func _build_hud() -> void:
	var layer := CanvasLayer.new()
	_hud = Label.new()
	_hud.position = Vector2(16, 12)
	layer.add_child(_hud)
	add_child(layer)


func _update_hud() -> void:
	var w := combat.equipped_weapon
	var weapon_txt := "unarmed"
	if w != null:
		weapon_txt = "spear dmg %.0f / dura %.0f" % [w.get_stat("damage"), w.get_stat("durability")]
	_hud.text = "\n".join([
		_msg,
		"",
		"HP %.0f/%.0f   Stamina %.0f/%.0f" % [combat.health, combat.max_health, combat.stamina, combat.max_stamina],
		"Weapon: " + weapon_txt,
		"Inventory: " + _inv_summary(),
		"Skills: gather L%d  craft L%d  hunt L%d" % [
			SkillSystem.get_level("gathering"), SkillSystem.get_level("crafting"), SkillSystem.get_level("hunting")],
	])


func _inv_summary() -> String:
	var counts: Dictionary = {}
	for it in inventory.items:
		var def := Database.get_entity(it.def_id)
		var name: String = def.display_name if def != null else it.def_id
		counts[name] = int(counts.get(name, 0)) + it.quantity
	if counts.is_empty():
		return "(empty)"
	var parts: Array = []
	for name in counts:
		parts.append("%s x%d" % [name, counts[name]])
	return ", ".join(parts)
