@tool
class_name Inventory
extends Resource

## Holds unique ItemInstances. Stacking is only attempted for items that are
## genuinely identical (see ItemInstance.is_stackable_with); materials and
## crafted gear always remain distinct entries.

@export var items: Array[ItemInstance] = []


func add(instance: ItemInstance) -> void:
	if instance == null:
		return
	for existing in items:
		if existing.is_stackable_with(instance):
			existing.quantity += instance.quantity
			return
	items.append(instance)


func remove(instance: ItemInstance) -> bool:
	var idx := items.find(instance)
	if idx == -1:
		return false
	items.remove_at(idx)
	return true


func query_by_tag(tag: String) -> Array[ItemInstance]:
	var result: Array[ItemInstance] = []
	for inst in items:
		var def := Database.get_entity(inst.def_id)
		if def != null and def.has_tag(tag):
			result.append(inst)
	return result


func query_by_def(def_id: String) -> Array[ItemInstance]:
	var result: Array[ItemInstance] = []
	for inst in items:
		if inst.def_id == def_id:
			result.append(inst)
	return result


func count() -> int:
	var total := 0
	for inst in items:
		total += inst.quantity
	return total
