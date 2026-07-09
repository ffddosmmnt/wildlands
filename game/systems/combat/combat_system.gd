class_name CombatSystem
extends RefCounted

## Data-driven combat resolution. Like CraftingSystem, there is NO per-weapon
## code: a weapon's behaviour comes entirely from its data —
##   * per-instance stats (damage, durability, attack_speed, weight) from the
##     crafted ItemInstance, so better materials => a better weapon;
##   * static per-type stats (range) from its ItemDef properties, so a spear's
##     reach is data, not an `if weapon == spear`.
## Adding an axe or bow = new ItemDef + recipe, no change here.

const HUNTING_XP_ON_KILL := 20.0
# ponytail: global wear rate; move to weapon data if weapons ever need distinct
# durability loss (a fragile knife vs a sturdy spear).
const DURABILITY_LOSS_PER_HIT := 1.0
const UNARMED_RANGE := 1.0


class AttackResult:
	var hit: bool = false
	## "ok" | "out_of_range" | "no_stamina" | "broken"
	var reason: String = ""
	var damage: float = 0.0
	var target_killed: bool = false


## Resolve a strike. `distance` is the world gap between attacker and target,
## passed in so this core stays position-agnostic (the Node layer measures it).
static func attack(attacker: CombatEntity, target: CombatEntity, distance: float) -> AttackResult:
	var r := AttackResult.new()
	var weapon := attacker.equipped_weapon
	var w := resolve_weapon(weapon)

	# Reach: the spear's advantage is purely its data `range`.
	if distance > w["range"]:
		r.reason = "out_of_range"
		return r

	# A broken weapon can't strike (durability matters).
	if weapon != null and weapon.get_stat("durability") <= 0.0:
		r.reason = "broken"
		return r

	# Stamina gates aggression — heavier weapons cost more effort.
	var cost := stamina_cost(weapon)
	if attacker.stamina < cost:
		r.reason = "no_stamina"
		return r
	attacker.stamina -= cost

	# The one universal damage rule: base + weapon, mitigated by defense,
	# never below 1 on a landed hit.
	var raw: float = attacker.attack_power + w["damage"]
	r.damage = target.take_damage(maxf(1.0, raw - target.defense))
	r.hit = true
	r.reason = "ok"

	# Wear the crafted weapon.
	if weapon != null:
		weapon.properties["durability"] = maxf(0.0, weapon.get_stat("durability") - DURABILITY_LOSS_PER_HIT)

	if not target.is_alive():
		r.target_killed = true
		EventBus.action_performed.emit("hunting", HUNTING_XP_ON_KILL)  # learn-by-doing

	return r


## {damage, range, attack_speed, durability} for a weapon (or unarmed).
static func resolve_weapon(weapon: ItemInstance) -> Dictionary:
	if weapon == null:
		return {"damage": 0.0, "range": UNARMED_RANGE, "attack_speed": 1.0, "durability": 0.0}
	var def := Database.get_entity(weapon.def_id)
	var reach: float = float(def.get_property("range", UNARMED_RANGE)) if def != null else UNARMED_RANGE
	return {
		"damage": weapon.get_stat("damage"),
		"range": reach,
		"attack_speed": weapon.get_stat("attack_speed"),
		"durability": weapon.get_stat("durability"),
	}


## Seconds between attacks, derived from the material-driven attack_speed rating.
## Heavier handle -> lower attack_speed -> longer cooldown. The world layer gates
## real-time attacks on this; here it demonstrates material-driven timing.
static func cooldown(weapon: ItemInstance) -> float:
	var spd: float = resolve_weapon(weapon)["attack_speed"]
	return 10.0 / maxf(0.1, spd)


static func stamina_cost(weapon: ItemInstance) -> float:
	if weapon == null:
		return 5.0
	return 5.0 + weapon.get_stat("weight") * 0.5
