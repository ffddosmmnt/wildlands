extends Node

## Autoload singleton. Decouples systems: gathering/crafting emit here, and
## SkillSystem listens, so no system needs a direct reference to skills.
## This is the backbone of learn-by-doing progression.

## A gameplay action that should train a skill.
## skill_id: which skill; amount: XP to award.
signal action_performed(skill_id: String, amount: float)

## A resource was gathered from a node.
signal resource_gathered(instance: ItemInstance, node_id: String)

## An item was successfully crafted.
signal item_crafted(recipe_id: String, result: ItemInstance)

## A skill leveled up (emitted by SkillSystem).
signal skill_leveled_up(skill_id: String, new_level: int, unlocks: Array)
