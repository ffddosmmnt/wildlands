class_name GatheringSystem
extends RefCounted

## Turns a ResourceNode harvest into unique material ItemInstances. Each drop's
## quality is influenced by the player's gathering skill and tool quality
## (per DATA_SCHEMA: better tool/skill -> higher chance of quality materials).
## Trains the gathering skill via EventBus.
##
## A resource definition's `properties.drop_table` is an Array of Dictionaries:
##   { "material": "wood_soft", "base_quality": 40 }

const XP_PER_GATHER := 8.0


## Returns the Array[ItemInstance] harvested. Rolls quality and emits events.
static func gather(node: ResourceNode, tool_quality: float = 0.0) -> Array:
	var drops: Array = []
	if node == null or node.is_depleted() or node.definition == null:
		return drops

	# Quality roll is shared with hunting loot — see LootSystem.
	var drop_table: Array = node.definition.get_property("drop_table", [])
	drops = LootSystem.roll(drop_table, SkillSystem.get_bonus("gathering"), tool_quality)
	for inst in drops:
		EventBus.resource_gathered.emit(inst, node.resource_id)

	node.uses_remaining -= 1
	if not drops.is_empty():
		EventBus.action_performed.emit("gathering", XP_PER_GATHER)
	return drops
