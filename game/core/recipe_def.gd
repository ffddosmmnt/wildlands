@tool
class_name RecipeDef
extends Resource

## A flexible, category-based recipe. Recipes never name concrete ingredients
## ("raptor bone + acacia wood"); they require material CATEGORIES via tags
## ("sharp_material" + "handle_material"). The same recipe therefore produces
## different results depending on the materials the player supplies.

@export var id: String = ""
@export var display_name: String = ""
## The ItemDef id this recipe produces (e.g. "spear").
@export var output_type: String = ""
## Skill trained by performing this craft, and the XP awarded.
@export var skill_id: String = "crafting"
@export var xp_reward: float = 10.0

## Each slot is a Dictionary:
##   {
##     "slot_id":     "tip",              # bound as a variable in formulas
##     "accepts_tag": "sharp_material",   # instance def must have this tag
##     "count":       1,
##   }
@export var slots: Array[Dictionary] = []

## output stat name -> formula string evaluated with Godot's Expression.
## Slot materials are exposed as objects with their properties, e.g.:
##   "damage":     "tip.sharpness * 0.7 + tip.hardness * 0.3"
##   "durability": "tip.density + tip.quality"
##   "weight":     "tip.weight + handle.weight"
## A `skill_bonus` float (0..1+) is also available in every formula.
@export var stat_formulas: Dictionary = {}
