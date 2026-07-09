class_name CraftingSystem
extends RefCounted

## Data-driven crafting. There is NO per-recipe code: a RecipeDef declares its
## material slots (by tag) and its output stat formulas, and this system:
##   1. validates the supplied instances against the slots,
##   2. evaluates each formula with Godot's Expression, binding each slot's
##      material properties as a variable, plus a `skill_bonus`,
##   3. produces a new unique ItemInstance and fires XP / crafted events.
##
## The SAME recipe yields a weak or strong result purely from the materials.

class CraftResult:
	var success: bool = false
	var error: String = ""
	var item: ItemInstance = null


## selections: slot_id (String) -> ItemInstance
static func craft(recipe: RecipeDef, selections: Dictionary, skill_bonus: float = 0.0) -> CraftResult:
	var result := CraftResult.new()
	if recipe == null:
		result.error = "null recipe"
		return result

	# 1. Validate slots and collect each slot's stat table.
	var slot_props: Dictionary = {}   # slot_id -> Dictionary of stats
	for slot in recipe.slots:
		var slot_id: String = slot.get("slot_id", "")
		var accepts_tag: String = slot.get("accepts_tag", "")
		var inst: ItemInstance = selections.get(slot_id)
		if inst == null:
			result.error = "missing material for slot '%s'" % slot_id
			return result
		var def := Database.get_entity(inst.def_id)
		if def == null or (accepts_tag != "" and not def.has_tag(accepts_tag)):
			result.error = "material '%s' does not satisfy slot '%s' (needs tag '%s')" % [
				inst.def_id, slot_id, accepts_tag]
			return result
		slot_props[slot_id] = inst.properties

	# 2. Evaluate output formulas.
	var out_props: Dictionary = {}
	var var_names: Array = slot_props.keys()
	var_names.append("skill_bonus")
	for stat_name in recipe.stat_formulas:
		var formula: String = recipe.stat_formulas[stat_name]
		var value := _eval_formula(formula, var_names, slot_props, skill_bonus)
		if is_nan(value):
			result.error = "bad formula for '%s': %s" % [stat_name, formula]
			return result
		out_props[stat_name] = value

	# 3. Produce the unique crafted item.
	var item := ItemInstance.create(recipe.output_type, out_props)
	result.item = item
	result.success = true

	EventBus.item_crafted.emit(recipe.id, item)
	EventBus.action_performed.emit(recipe.skill_id, recipe.xp_reward)
	return result


static func _eval_formula(formula: String, var_names: Array, slot_props: Dictionary, skill_bonus: float) -> float:
	var expr := Expression.new()
	# Slot materials are exposed as MaterialVars so formulas read `tip.sharpness`.
	var inputs: Array = []
	for name in var_names:
		if name == "skill_bonus":
			inputs.append(skill_bonus)
		else:
			inputs.append(_MaterialVars.new(slot_props[name]))
	var err := expr.parse(formula, PackedStringArray(var_names))
	if err != OK:
		push_warning("[Crafting] parse error in '%s': %s" % [formula, expr.get_error_text()])
		return NAN
	var out = expr.execute(inputs, null, true)
	if expr.has_execute_failed():
		push_warning("[Crafting] execute error in '%s': %s" % [formula, expr.get_error_text()])
		return NAN
	return float(out)


## Wraps a properties Dictionary so a formula can use dot access (tip.sharpness).
## Missing properties resolve to 0.0 rather than erroring.
class _MaterialVars:
	var _props: Dictionary
	func _init(props: Dictionary) -> void:
		_props = props
	func _get(property: StringName) -> Variant:
		return float(_props.get(String(property), 0.0))
