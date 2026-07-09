extends Node

## Autoload singleton implementing learn-by-doing progression. It listens to
## EventBus.action_performed and awards XP to the relevant skill — gathering,
## crafting, hunting, cooking, survival. Other systems never call it directly;
## they just describe the action they performed.

class SkillState:
	var level: int = 0
	var xp: float = 0.0

var _states: Dictionary = {}   # skill_id -> SkillState


func _ready() -> void:
	EventBus.action_performed.connect(_on_action_performed)
	_init_states()


func _init_states() -> void:
	# Ensure a state exists for every defined skill.
	for skill in Database.all_skills():
		if not _states.has(skill.id):
			_states[skill.id] = SkillState.new()


func _on_action_performed(skill_id: String, amount: float) -> void:
	add_xp(skill_id, amount)


func add_xp(skill_id: String, amount: float) -> void:
	var def := Database.get_skill(skill_id)
	if def == null:
		push_warning("[Skill] unknown skill '%s'" % skill_id)
		return
	var state: SkillState = _states.get(skill_id)
	if state == null:
		state = SkillState.new()
		_states[skill_id] = state
	state.xp += amount
	# Consume XP into levels using the definition's curve.
	while state.level < def.max_level and state.xp >= def.xp_for_level(state.level):
		state.xp -= def.xp_for_level(state.level)
		state.level += 1
		var unlocks: Array = def.unlock_table.get(state.level, [])
		EventBus.skill_leveled_up.emit(skill_id, state.level, unlocks)


func get_level(skill_id: String) -> int:
	var state: SkillState = _states.get(skill_id)
	return state.level if state != null else 0


func get_xp(skill_id: String) -> float:
	var state: SkillState = _states.get(skill_id)
	return state.xp if state != null else 0.0


## A normalized bonus (0.0+) other systems fold into their formulas,
## e.g. crafting quality or gathering yield. 0.02 per level by default.
func get_bonus(skill_id: String) -> float:
	return get_level(skill_id) * 0.02
