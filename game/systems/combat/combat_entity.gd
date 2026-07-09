class_name CombatEntity
extends RefCounted

## The combat state of any fighter — player, creature, or dummy. It is a plain
## stat holder (no Node, no scene) so it is headless-testable and composed INTO
## a Node3D later rather than inherited from. Creature stats flow in as data via
## from_stats(), so a new creature is a .tres entry, not a subclass.

var display_name: String = "entity"
var max_health: float = 100.0
var health: float = 100.0
var max_stamina: float = 100.0
var stamina: float = 100.0
## Base (unarmed) attack. Equipment damage is added on top — power comes from
## gear, per the Durango pillar, not from this number.
var attack_power: float = 0.0
var defense: float = 0.0
var move_speed: float = 3.0
## The crafted weapon ItemInstance in hand (null = unarmed). Its rolled stats
## (damage, durability, attack_speed, weight) drive combat.
var equipped_weapon: ItemInstance = null


## Build from a stats Dictionary — the shape a creature .tres will carry
## (per DATA_SCHEMA "Creature: stats"). Missing keys fall back to defaults.
static func from_stats(stats: Dictionary) -> CombatEntity:
	var e := CombatEntity.new()
	e.display_name = String(stats.get("name", "entity"))
	e.max_health = float(stats.get("health", 100.0))
	e.health = e.max_health
	e.max_stamina = float(stats.get("stamina", 100.0))
	e.stamina = e.max_stamina
	e.attack_power = float(stats.get("attack", 0.0))
	e.defense = float(stats.get("defense", 0.0))
	e.move_speed = float(stats.get("speed", 3.0))
	return e


func is_alive() -> bool:
	return health > 0.0


func take_damage(amount: float) -> float:
	var dealt: float = maxf(0.0, amount)
	health = maxf(0.0, health - dealt)
	return dealt


## Stamina recovers over time. The world/AI layer calls this per frame; the
## headless slice exercises discrete attacks and doesn't need it.
func regen_stamina(delta: float, rate: float = 15.0) -> void:
	stamina = minf(max_stamina, stamina + rate * delta)


func equip(weapon: ItemInstance) -> void:
	equipped_weapon = weapon
