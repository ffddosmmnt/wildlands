@tool
class_name SkillDef
extends Resource

## A skill definition for the learn-by-doing progression system.
## Skills improve because the player performs related actions, not through
## generic EXP farming. XP thresholds follow a simple base * growth^level curve
## so the curve stays data-driven without hardcoding per-skill tables.

@export var id: String = ""
@export var display_name: String = ""
@export var max_level: int = 20
## XP required for level 1. Each level costs xp_base * (xp_growth ^ level).
@export var xp_base: float = 100.0
@export var xp_growth: float = 1.35
## level -> Array of unlocked recipe ids (or other unlock payloads).
@export var unlock_table: Dictionary = {}


## XP needed to advance FROM `level` to `level + 1`.
func xp_for_level(level: int) -> float:
	return xp_base * pow(xp_growth, level)
