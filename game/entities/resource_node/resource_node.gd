class_name ResourceNode
extends Node3D

## A harvestable node in the world (tree, rock, plant). It is a thin wrapper:
## all of its behavior comes from a resource GameEntity in the Database,
## referenced by resource_id. Its drop table lives in the definition's
## `properties`, so new node types are added as data, not code.

## Database id of the resource_node GameEntity backing this node.
@export var resource_id: String = ""
## Remaining harvests before the node is depleted.
@export var uses_remaining: int = 3

var definition: GameEntity


func _ready() -> void:
	definition = Database.get_entity(resource_id)
	if definition == null:
		push_warning("[ResourceNode] unknown resource_id '%s'" % resource_id)


func is_depleted() -> bool:
	return uses_remaining <= 0
