@tool
class_name MaterialDef
extends GameEntity

## A material definition (Durango-style). Materials are NOT rarity items:
## they carry stats. Every source of a base material (bone, wood, leather)
## starts from base_properties and applies modifiers, so "raptor bone" and
## "large dinosaur bone" share base "bone" but differ in sharpness/hardness.
##
## Not every material needs every property (per DATA_SCHEMA).

## The base material category, e.g. "bone", "wood", "leather", "stone".
@export var base_material: String = ""
## Base stat values shared by all sources of this base material.
## Keys: hardness, density, sharpness, weight, flexibility, toughness, ...
@export var base_properties: Dictionary = {}
## Per-source deltas applied on top of base_properties.
@export var modifiers: Dictionary = {}


## The resolved stat table for this material definition (base + modifiers).
## This is the "template" — actual item instances roll quality on top.
func resolved_properties() -> Dictionary:
	var result: Dictionary = base_properties.duplicate(true)
	for key in modifiers:
		result[key] = float(result.get(key, 0.0)) + float(modifiers[key])
	return result
