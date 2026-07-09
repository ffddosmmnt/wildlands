class_name CreatureNode
extends CharacterBody3D

## World presence for a CreatureInstance. Movement is driven by the creature's
## behavior module (approach/flee/attack) — no per-species code here. All combat
## goes through the shared CombatSystem/CombatEntity.

const ATTACK_COOLDOWN := 1.2   # ponytail: fixed unarmed swing rate; move to data if creatures need distinct cadence

@export var creature_id: String = ""

var creature: CreatureInstance
var _player: Node3D          # duck-typed (has .combat, .global_position) to avoid a Player<->CreatureNode class cycle
var _attack_cd := 0.0


func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	creature = CreatureInstance.spawn(creature_id)
	if creature == null:
		push_warning("[CreatureNode] bad creature_id '%s'" % creature_id)
		queue_free()
		return
	add_to_group("interactable")
	add_to_group("creature")
	_build_placeholder()


func _physics_process(delta: float) -> void:
	if creature == null or not creature.is_alive():
		return
	if _player == null or not is_instance_valid(_player):
		_player = get_tree().get_first_node_in_group("player") as Node3D
		if _player == null:
			return
	_attack_cd = maxf(0.0, _attack_cd - delta)
	creature.combat.regen_stamina(delta)

	var to_player: Vector3 = _player.global_position - global_position
	to_player.y = 0.0
	var dist := to_player.length()
	var speed: float = float(creature.def.get_property("stats", {}).get("speed", 3.0))

	match creature.decide(dist):
		CreatureBehavior.Intent.APPROACH:
			velocity = to_player.normalized() * speed
		CreatureBehavior.Intent.FLEE:
			velocity = -to_player.normalized() * speed
		CreatureBehavior.Intent.ATTACK:
			velocity = Vector3.ZERO
			_try_attack_player(dist)
		_:
			velocity = Vector3.ZERO
	move_and_slide()


func _try_attack_player(dist: float) -> void:
	if _attack_cd > 0.0:
		return
	var res := CombatSystem.attack(creature.combat, _player.combat, dist)
	if res.hit:
		_attack_cd = ATTACK_COOLDOWN


func _build_placeholder() -> void:
	var diet := String(creature.def.get_property("diet", ""))
	var color := Color(0.8, 0.2, 0.2) if diet == "carnivore" else Color(0.35, 0.7, 0.35)
	var mesh := MeshInstance3D.new()
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.4
	capsule.height = 1.4
	mesh.mesh = capsule
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mesh.material_override = mat
	mesh.position.y = 0.7
	add_child(mesh)
	var col := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.4
	shape.height = 1.4
	col.shape = shape
	col.position.y = 0.7
	add_child(col)
