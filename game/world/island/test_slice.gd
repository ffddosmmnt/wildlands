extends Node

## Headless-friendly vertical slice test. Proves the foundation loop end to end:
##   gather -> craft spear -> the SAME recipe yields different stats by material
##   -> crafting/gathering XP is awarded via the learn-by-doing pipeline.
##
## Run:  godot --headless --path game
## (test_slice.tscn is the project's main scene.) Exits 0 on pass, 1 on fail.

var _failures: int = 0
var _crafted_events: int = 0


func _ready() -> void:
	seed(12345)  # deterministic quality rolls
	EventBus.item_crafted.connect(func(_r, _i): _crafted_events += 1)

	print("=== Wildlands foundation slice ===")

	# --- Spear A: poor materials (small bone tip + soft wood handle) ---
	var tip_a := _gather_one("carcass_small")
	var handle_a := _gather_one("tree_basic")
	var spear_a := _craft_spear(tip_a, handle_a)

	# --- Spear B: good materials (predator bone tip + hardwood handle) ---
	var tip_b := _gather_one("carcass_predator")
	var handle_b := _gather_one("tree_hardwood")
	var spear_b := _craft_spear(tip_b, handle_b)

	print("\n-- Results (same recipe_spear, different materials) --")
	_print_spear("Spear A (soft wood + small bone)", spear_a)
	_print_spear("Spear B (hardwood + predator bone)", spear_b)

	# --- Assertions ---
	_check(spear_a != null and spear_b != null, "both spears crafted")
	if spear_a != null and spear_b != null:
		_check(spear_b.get_stat("damage") > spear_a.get_stat("damage"),
			"better materials -> more damage")
		_check(spear_b.get_stat("durability") > spear_a.get_stat("durability"),
			"better materials -> more durability")
	_check(_crafted_events == 2, "item_crafted fired for each craft")
	_check(SkillSystem.get_xp("crafting") > 0.0 or SkillSystem.get_level("crafting") > 0,
		"crafting skill gained XP (learn-by-doing)")
	_check(SkillSystem.get_xp("gathering") > 0.0 or SkillSystem.get_level("gathering") > 0,
		"gathering skill gained XP (learn-by-doing)")

	print("\ncrafting skill: L%d (%.1f xp)   gathering skill: L%d (%.1f xp)" % [
		SkillSystem.get_level("crafting"), SkillSystem.get_xp("crafting"),
		SkillSystem.get_level("gathering"), SkillSystem.get_xp("gathering")])

	if _failures == 0:
		print("\nRESULT: PASS (all checks green)")
	else:
		print("\nRESULT: FAIL (%d check(s) failed)" % _failures)

	get_tree().quit(1 if _failures > 0 else 0)


func _gather_one(resource_id: String) -> ItemInstance:
	var node := ResourceNode.new()
	node.resource_id = resource_id
	add_child(node)  # _ready resolves the definition
	var drops := GatheringSystem.gather(node)
	node.queue_free()
	if drops.is_empty():
		push_error("nothing gathered from %s" % resource_id)
		return null
	return drops[0]


func _craft_spear(tip: ItemInstance, handle: ItemInstance) -> ItemInstance:
	if tip == null or handle == null:
		return null
	var recipe := Database.get_recipe("recipe_spear")
	var bonus := SkillSystem.get_bonus("crafting")
	var res := CraftingSystem.craft(recipe, {"tip": tip, "handle": handle}, bonus)
	if not res.success:
		push_error("craft failed: %s" % res.error)
		return null
	return res.item


func _print_spear(label: String, spear: ItemInstance) -> void:
	if spear == null:
		print("  %s: <none>" % label)
		return
	print("  %s -> damage %.1f | durability %.1f | weight %.1f | atk_speed %.2f" % [
		label, spear.get_stat("damage"), spear.get_stat("durability"),
		spear.get_stat("weight"), spear.get_stat("attack_speed")])


func _check(condition: bool, label: String) -> void:
	if condition:
		print("  [PASS] %s" % label)
	else:
		_failures += 1
		print("  [FAIL] %s" % label)
