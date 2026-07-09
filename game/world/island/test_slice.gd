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

	_check(Database.validate().is_empty(), "data validation clean")

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

	# --- Combat: the crafted spear is equippable and damages a dummy target ---
	print("\n-- Combat (equipment-driven, same spears) --")
	_run_combat_checks(spear_a, spear_b)

	# --- Creature loop: hunt a creature, loot its material, craft a better spear ---
	print("\n-- Creature (data-driven, closes the survival loop) --")
	_run_creature_checks(spear_a)

	# --- World glue: a real Player node drives the same systems via interaction ---
	print("\n-- World glue (player node drives the systems) --")
	_run_world_glue_checks()

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


func _run_creature_checks(starter_spear: ItemInstance) -> void:
	if starter_spear == null:
		_check(false, "creature: starter spear available")
		return

	# Creatures come from data; behavior is a data-selected module.
	var herbivore := CreatureInstance.spawn("herbivore_small")
	var predator := CreatureInstance.spawn("predator_medium")
	_check(herbivore != null and predator != null, "creatures spawned from data")
	if herbivore == null or predator == null:
		return

	_check(herbivore.decide(2.0) == CreatureBehavior.Intent.FLEE,
		"passive herbivore flees when player is near")
	_check(predator.decide(1.0) == CreatureBehavior.Intent.ATTACK,
		"aggressive predator attacks in range")
	_check(predator.decide(5.0) == CreatureBehavior.Intent.APPROACH,
		"aggressive predator approaches from afar")

	# 1 + 2. Fight and kill the predator with the (weak) starting spear.
	var player := CombatEntity.from_stats({
		"name": "Player", "health": 100, "stamina": 100, "attack": 5, "defense": 3})
	player.equip(starter_spear)
	var reach: float = CombatSystem.resolve_weapon(starter_spear)["range"]
	var swings := 0
	while predator.is_alive() and swings < 50:
		var res := CombatSystem.attack(player, predator.combat, reach - 0.5)
		if res.reason == "no_stamina":
			player.regen_stamina(1.0)   # a beat of recovery between strikes
		swings += 1
	_check(not predator.is_alive(), "predator killed with the starting spear")

	# 3. Receive material drops (hunting skill + tool influence quality).
	var loot := predator.generate_loot(SkillSystem.get_bonus("hunting"), starter_spear.get_stat("damage"))
	_check(loot.size() > 0, "killed predator drops material")
	var bone: ItemInstance = loot[0] if loot.size() > 0 else null
	_check(bone != null and Database.get_entity(bone.def_id).has_tag("sharp_material"),
		"drop is a usable sharp material")
	_check(SkillSystem.get_xp("hunting") > 0.0 or SkillSystem.get_level("hunting") > 0,
		"hunting skill gained XP from the kill (learn-by-doing)")

	# 4 + 5. Use the creature material to craft a better spear than the starter.
	var handle := _gather_one("tree_hardwood")
	var upgraded := _craft_spear(bone, handle)
	_check(upgraded != null and upgraded.get_stat("damage") > starter_spear.get_stat("damage"),
		"looted material crafts a stronger spear (survival loop closed)")

	print("  starter spear dmg %.1f -> looted-bone spear dmg %.1f | predator down in %d swings | hunting L%d (%.0f xp)" % [
		starter_spear.get_stat("damage"),
		upgraded.get_stat("damage") if upgraded != null else 0.0,
		swings, SkillSystem.get_level("hunting"), SkillSystem.get_xp("hunting")])


## Drives a real Player node through the full loop with no input events — proves
## the presentation glue (interact routing, gather, craft+equip, fight, loot)
## wires into the systems, not just the systems in isolation.
func _run_world_glue_checks() -> void:
	var player := Player.new()
	add_child(player)                       # _ready builds combat/inventory/interactor/hud
	player.global_position = Vector3.ZERO

	# Gather a sharp material (stone) via the interaction router.
	var stone := _place_interactable("stone_common", Vector3(1, 0, 0))
	player._interact()
	var got_sharp := player.inventory.query_by_tag("sharp_material").size() > 0
	stone.global_position = Vector3(999, 0, 0)   # move out of range so it isn't "nearest" next

	# Gather two handles (wood) — one per craft below.
	var tree := _place_interactable("tree_basic", Vector3(1, 0, 0))
	player._interact()
	player._interact()
	var got_handles := player.inventory.query_by_tag("handle_material").size() >= 2
	_check(got_sharp and got_handles, "player gathers sharp + handles via interact (E)")

	# Craft + auto-equip a spear, consuming its inputs.
	var inv_before := player.inventory.count()
	player._craft_spear()
	var starter := player.combat.equipped_weapon
	_check(starter != null, "player crafts and auto-equips a spear (C)")
	_check(player.inventory.count() < inv_before, "crafting consumed the input materials")
	tree.global_position = Vector3(999, 0, 0)

	# Fight + loot a predator via the interaction router.
	var starter_dmg: float = starter.get_stat("damage") if starter != null else 0.0
	var cnode := CreatureNode.new()
	cnode.creature_id = "predator_medium"
	add_child(cnode)
	cnode.global_position = Vector3(1, 0, 0)     # within spear reach
	var guard := 0
	while cnode.creature != null and cnode.creature.is_alive() and guard < 100:
		player._interact()
		player.combat.regen_stamina(1.0)
		guard += 1
	_check(cnode.creature != null and not cnode.creature.is_alive(), "player kills predator via interact (E)")
	_check(player.inventory.query_by_def("bone_predator").size() > 0, "kill drops loot into player inventory")

	# Craft a better spear from the looted bone (in-world loop closed).
	player._craft_spear()
	var upgraded_dmg: float = player.combat.equipped_weapon.get_stat("damage")
	_check(upgraded_dmg > starter_dmg, "looted bone crafts a stronger spear in-world (loop closed)")

	print("  in-world: starter dmg %.0f -> upgraded dmg %.0f (killed predator in %d swings)" % [
		starter_dmg, upgraded_dmg, guard])
	player.queue_free()


func _place_interactable(res_id: String, pos: Vector3) -> ResourceNode:
	var node := ResourceNode.new()
	node.resource_id = res_id
	node.add_to_group("interactable")
	add_child(node)
	node.global_position = pos
	return node


func _run_combat_checks(spear_a: ItemInstance, spear_b: ItemInstance) -> void:
	if spear_a == null or spear_b == null:
		_check(false, "combat: crafted spears available")
		return

	var player := CombatEntity.from_stats({
		"name": "Player", "health": 100, "stamina": 100, "attack": 5, "defense": 2})
	var dummy := CombatEntity.from_stats({
		"name": "Dummy", "health": 200, "stamina": 0, "attack": 0, "defense": 3})

	# ACCEPTANCE: equip the crafted spear, strike within reach, dummy takes damage.
	player.equip(spear_b)
	var reach: float = CombatSystem.resolve_weapon(spear_b)["range"]
	var hp_before := dummy.health
	var res := CombatSystem.attack(player, dummy, reach - 0.5)
	_check(res.hit and res.damage > 0.0, "equipped spear damages dummy target")
	_check(dummy.health < hp_before, "dummy health decreased by the hit")

	# Reach advantage: beyond the spear's range the same strike whiffs.
	var res_far := CombatSystem.attack(player, dummy, reach + 2.0)
	_check(not res_far.hit and res_far.reason == "out_of_range",
		"out of range -> no damage (reach matters)")

	# Material affects damage: the better spear hits harder (isolated hit).
	_check(_hit_damage(spear_b) > _hit_damage(spear_a),
		"better materials -> more combat damage")

	# Attack timing is material-driven: heavier spear swings slower.
	_check(CombatSystem.cooldown(spear_b) > CombatSystem.cooldown(spear_a),
		"heavier spear -> longer attack cooldown")

	# Durability: striking wears the weapon down.
	var dura_before := spear_b.get_stat("durability")
	CombatSystem.attack(player, dummy, reach - 0.5)
	_check(spear_b.get_stat("durability") < dura_before,
		"attacking reduces weapon durability")

	# Stamina gates attacks: a drained fighter can't strike.
	player.stamina = 0.0
	var res_tired := CombatSystem.attack(player, dummy, reach - 0.5)
	_check(not res_tired.hit and res_tired.reason == "no_stamina",
		"no stamina -> cannot attack (preparation matters)")

	print("  spear_b: dmg %.1f | reach %.1f | cooldown %.2fs | dura now %.1f | dummy hp %.1f/%.1f" % [
		CombatSystem.resolve_weapon(spear_b)["damage"], reach, CombatSystem.cooldown(spear_b),
		spear_b.get_stat("durability"), dummy.health, dummy.max_health])


## Damage a fresh attacker deals with `spear` against a fixed-defense target,
## isolating the weapon's contribution.
func _hit_damage(spear: ItemInstance) -> float:
	var atk := CombatEntity.from_stats({"stamina": 100, "attack": 5})
	atk.equip(spear)
	var target := CombatEntity.from_stats({"health": 9999, "defense": 3})
	var reach: float = CombatSystem.resolve_weapon(spear)["range"]
	return CombatSystem.attack(atk, target, reach - 0.1).damage


func _check(condition: bool, label: String) -> void:
	if condition:
		print("  [PASS] %s" % label)
	else:
		_failures += 1
		print("  [FAIL] %s" % label)
