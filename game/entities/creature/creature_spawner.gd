class_name CreatureSpawner
extends Node3D

## Spawns one creature (by data id) at its position and respawns it a while
## after it dies, so the world keeps offering hunts. Creature type is pure data.

@export var creature_id: String = ""
@export var respawn_seconds: float = 8.0

var _current: CreatureNode
var _timer := 0.0


func _ready() -> void:
	_spawn()


func _process(delta: float) -> void:
	if _current != null and is_instance_valid(_current):
		return
	_timer -= delta
	if _timer <= 0.0:
		_spawn()


func _spawn() -> void:
	var c := CreatureNode.new()
	c.creature_id = creature_id
	get_parent().add_child(c)
	c.global_position = global_position
	_current = c
	_timer = respawn_seconds
