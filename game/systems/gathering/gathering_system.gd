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

	var skill_bonus: float = SkillSystem.get_bonus("gathering")
	var drop_table: Array = node.definition.get_property("drop_table", [])
	for entry in drop_table:
		var mat_id: String = entry.get("material", "")
		var mat := Database.get_material(mat_id)
		if mat == null:
			push_warning("[Gathering] unknown material '%s'" % mat_id)
			continue
		# Roll concrete stats: material template + a rolled quality.
		var props: Dictionary = mat.resolved_properties()
		var base_quality: float = float(entry.get("base_quality", 30.0))
		var quality: float = clampf(
			base_quality * (1.0 + skill_bonus) + tool_quality * 0.5 + randf_range(-5.0, 5.0),
			1.0, 100.0)
		props["quality"] = quality
		var inst := ItemInstance.create(mat_id, props)
		drops.append(inst)
		EventBus.resource_gathered.emit(inst, node.resource_id)

	node.uses_remaining -= 1
	if not drops.is_empty():
		EventBus.action_performed.emit("gathering", XP_PER_GATHER)
	return drops
