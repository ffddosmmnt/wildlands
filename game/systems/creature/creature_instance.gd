class_name CreatureInstance
extends RefCounted

## A live creature: its definition (a "creature" GameEntity), a CombatEntity
## (REUSED — no separate combat logic), and a behavior module. Built from data,
## so a new creature is a .tres entry, never a subclass. A Node3D world wrapper
## composes one of these later; the fight/loot loop needs no scene.

var def: GameEntity
var combat: CombatEntity
var behavior: CreatureBehavior


static func spawn(creature_id: String) -> CreatureInstance:
	var def := Database.get_entity(creature_id)
	if def == null or def.type != "creature":
		push_warning("[Creature] '%s' is not a creature definition" % creature_id)
		return null
	var inst := CreatureInstance.new()
	inst.def = def
	inst.combat = CombatEntity.from_stats(def.get_property("stats", {}))
	inst.combat.display_name = def.display_name
	inst.behavior = CreatureBehavior.for_name(def.get_property("behavior", "passive"))
	return inst


func is_alive() -> bool:
	return combat.is_alive()


## Behavior intent for the player at `distance`. Returns a CreatureBehavior.Intent.
func decide(distance: float) -> int:
	return behavior.decide({
		"distance": distance,
		"aggression_range": float(def.get_property("aggression_range", 0.0)),
		"attack_range": float(def.get_property("stats", {}).get("attack_range", 1.0)),
	})


## Loot dropped when this creature dies. Quality scales with hunting skill and
## the tool used. Empty while still alive.
func generate_loot(hunting_bonus: float = 0.0, tool_quality: float = 0.0) -> Array:
	if is_alive():
		return []
	return LootSystem.roll(def.get_property("drop_table", []), hunting_bonus, tool_quality)
