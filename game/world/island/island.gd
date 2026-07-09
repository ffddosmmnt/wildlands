extends Node3D

## The playable test island. Builds a placeholder world in code (fewer fragile
## .tscn node ids) and wires the player loose in it. No gameplay logic lives
## here — it only places entities that drive the existing systems.

func _ready() -> void:
	_build_ground()
	_build_light()
	_spawn_player(Vector3(0, 0.0, 0))

	# Resource zone: wood (handle) + stone (first sharp tip) — the starter spear.
	_spawn_resource("tree_basic", Vector3(-4, 0, -3), 2.6, Color(0.2, 0.5, 0.2))
	_spawn_resource("tree_hardwood", Vector3(-6, 0, 1), 3.0, Color(0.15, 0.4, 0.15))
	_spawn_resource("stone_common", Vector3(3, 0, -4), 0.8, Color(0.5, 0.5, 0.55))
	_spawn_resource("stone_common", Vector3(5, 0, 0), 0.8, Color(0.5, 0.5, 0.55))

	# Danger zone: hunt the predator for bone_predator -> the upgraded spear.
	_spawn_creature("herbivore_small", Vector3(-9, 0, 6))
	_spawn_creature("predator_medium", Vector3(11, 0, 4))


func _build_ground() -> void:
	var mi := MeshInstance3D.new()
	var plane := PlaneMesh.new()
	plane.size = Vector2(60, 60)
	mi.mesh = plane
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.45, 0.42, 0.35)
	mi.material_override = mat
	add_child(mi)


func _build_light() -> void:
	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-55, -35, 0)
	add_child(light)


func _spawn_player(pos: Vector3) -> void:
	var p := Player.new()
	add_child(p)
	p.global_position = pos + Vector3(0, 0.0, 0)


func _spawn_resource(res_id: String, pos: Vector3, height: float, color: Color) -> void:
	var node := ResourceNode.new()
	node.resource_id = res_id
	node.add_to_group("interactable")
	var mi := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(0.9, height, 0.9)
	mi.mesh = box
	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	mi.material_override = mat
	mi.position.y = height * 0.5
	node.add_child(mi)
	add_child(node)
	node.global_position = pos


func _spawn_creature(creature_id: String, pos: Vector3) -> void:
	var spawner := CreatureSpawner.new()
	spawner.creature_id = creature_id
	add_child(spawner)
	spawner.global_position = pos
