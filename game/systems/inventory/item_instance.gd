@tool
class_name ItemInstance
extends Resource

## A UNIQUE runtime item. Two instances sharing the same def_id can have
## different stats — this is the core of the material/crafting depth.
## Extends Resource so instances serialize directly for future save/load.

@export var def_id: String = ""
## Unique per instance. Generated on creation.
@export var instance_id: String = ""
## The concrete, rolled/computed stats for THIS item (quality, sharpness,
## hardness, damage, durability, ...). Distinct from the definition's template.
@export var properties: Dictionary = {}
## Stack size. Only ever > 1 for simple, property-identical items.
@export var quantity: int = 1


static func create(from_def_id: String, props: Dictionary = {}, qty: int = 1) -> ItemInstance:
	var inst := ItemInstance.new()
	inst.def_id = from_def_id
	inst.instance_id = "%s_%d_%d" % [from_def_id, Time.get_ticks_usec(), randi()]
	inst.properties = props.duplicate(true)
	inst.quantity = qty
	return inst


func get_stat(key: String, default_value: float = 0.0) -> float:
	return float(properties.get(key, default_value))


## Two items stack only when they are the same simple item with identical
## properties. Materials (which carry rolled stats) therefore stay unique.
func is_stackable_with(other: ItemInstance) -> bool:
	if other == null or other.def_id != def_id:
		return false
	return properties == other.properties


func duplicate_instance() -> ItemInstance:
	return ItemInstance.create(def_id, properties, quantity)
