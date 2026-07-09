class_name CreatureBehavior
extends RefCounted

## Behavior modules decide a creature's intent from context. Creatures pick a
## module BY NAME in data, so behavior is never a creature-specific script and a
## handful of modules serve 100+ creatures. Add a module: new subclass + one line
## in for_name(); adding a creature never touches this file.

enum Intent { IDLE, FLEE, APPROACH, ATTACK }


## ctx: { distance, aggression_range, attack_range }. Base = do nothing.
func decide(_ctx: Dictionary) -> Intent:
	return Intent.IDLE


static func for_name(behavior: String) -> CreatureBehavior:
	match behavior:
		"passive": return PassiveBehavior.new()
		"aggressive": return AggressiveBehavior.new()
	push_warning("[Creature] unknown behavior '%s' -> passive" % behavior)
	return PassiveBehavior.new()


## Flees the moment the player enters its awareness range. (herbivore)
class PassiveBehavior extends CreatureBehavior:
	func decide(ctx: Dictionary) -> Intent:
		var dist := float(ctx.get("distance", 1e9))
		return Intent.FLEE if dist <= float(ctx.get("aggression_range", 0.0)) else Intent.IDLE


## Approaches within aggression range, strikes within attack range. (predator)
class AggressiveBehavior extends CreatureBehavior:
	func decide(ctx: Dictionary) -> Intent:
		var dist := float(ctx.get("distance", 1e9))
		if dist <= float(ctx.get("attack_range", 1.0)):
			return Intent.ATTACK
		if dist <= float(ctx.get("aggression_range", 1e9)):
			return Intent.APPROACH
		return Intent.IDLE
