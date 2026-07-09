class_name LootSystem
extends RefCounted

## Rolls a drop_table into unique material ItemInstances, quality influenced by
## skill and tool (per DATA_SCHEMA "Creature Loot": better skill/tool -> better
## materials). Shared by gathering (resource nodes) and hunting (creatures) so
## the quality math lives in ONE place — a creature's loot_table and a tree's
## drop_table are the same shape and roll the same way.
##
## drop_table entry: { "material": "bone_predator", "base_quality": 60 }

static func roll(drop_table: Array, skill_bonus: float = 0.0, tool_quality: float = 0.0) -> Array:
	var drops: Array = []
	for entry in drop_table:
		var mat_id: String = entry.get("material", "")
		var mat := Database.get_material(mat_id)
		if mat == null:
			push_warning("[Loot] unknown material '%s'" % mat_id)
			continue
		var props: Dictionary = mat.resolved_properties()
		var base_quality: float = float(entry.get("base_quality", 30.0))
		props["quality"] = clampf(
			base_quality * (1.0 + skill_bonus) + tool_quality * 0.5 + randf_range(-5.0, 5.0),
			1.0, 100.0)
		drops.append(ItemInstance.create(mat_id, props))
	return drops
