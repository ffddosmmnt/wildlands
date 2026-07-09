@tool
class_name GameEntity
extends Resource

## Base definition for every piece of content in the game.
## Content is authored as .tres files under res://data and never as code.
## Adding a new tree/item/creature = a new .tres, not a new class.

@export var id: String = ""
@export var display_name: String = ""
@export_multiline var description: String = ""
## Broad kind: "material", "item", "resource_node", "creature", ...
@export var type: String = ""
## Free-form tags used for recipe slot matching and queries
## (e.g. "wood_source", "sharp_material", "handle_material").
@export var tags: Array[String] = []
## Arbitrary per-entity data. Keeps content data-driven without new fields.
@export var properties: Dictionary = {}


func has_tag(tag: String) -> bool:
	return tags.has(tag)


func get_property(key: String, default_value: Variant = 0.0) -> Variant:
	return properties.get(key, default_value)
