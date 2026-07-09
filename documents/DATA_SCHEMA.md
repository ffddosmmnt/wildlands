Data Philosophy
The game must be data-driven.
Code defines behavior.
Data defines content.
Adding new content should not require modifying core systems.

───

Entity Structure
Base Entity:
id
name
type
tags
properties
Example:
tree_acacia:
type: resource_node
tags:
tree
wood_source
savanna_resource

───

Item Schema
All items use the same foundation.
Item:
id
category
properties
quality
source
modifiers

───

Material System
Materials are the heart of the game.
Materials contain stats.
Not rarity.

───

Universal Material Properties
Possible properties:
Hardness
Flexibility
Sharpness
Weight
Density
Durability
Quality
Not every material needs every property.

───

Material Example
Bone:
Base properties:
hardness
density
sharpness
Variants:
Small Creature Bone
Modifier:
lower weight
higher speed
Large Predator Bone
Modifier:
higher hardness
higher damage

───

Item Instance System
Important:
Items are unique instances.
Two items with the same name can have different values.
Example:
Bone #001
quality: 35
hardness: 20
Bone #002
quality: 80
hardness: 60

───

Recipe System
Avoid fixed recipes.
Recipes require material categories.
Example:
Spear:
Requires:
Sharp Material
Handle Material
Not:
Raptor Bone + Acacia Wood

───

Craft Result Calculation
Crafted items inherit material properties.
Example:
Weapon Damage:
sharpness
hardness
crafting skill bonus
Durability:
density
material quality

───

Weapon Schema
Weapon:
id
weapon_type
range
attack_speed
damage_formula
durability
material_slots

───

Spear Example
Material slots:
Tip Material
Handle Material
Generated stats:
Damage
Durability
Weight
Attack Speed

───

Creature Schema
Creature:
id
species
diet
size
behavior
stats
loot_table

───

Creature Behavior
Do not create unique AI scripts.
Use behavior modules.
Available modules:
Passive
Defensive
Aggressive
Territorial
Fearful
Curious

───

Creature Loot
Loot quality depends on:
Creature
Player skill
Tool quality
Example:
Better spear or harvesting tool:
Higher chance of quality materials.

───

Skill Schema
Skill:
id
level
experience
unlock_table

───

Skill EXP Source
Actions generate EXP.
Example:
Action:
Cut tree
Reward:
Gathering XP

───

Save Data Requirement
Save:
Player stats
Inventory item instances
Skill progression
World state
Camp state

───

Future Expansion Support
The schema must support:
1000+ items
100+ creatures
Multiple islands
More weapons
NPC systems
Economy systems
Do not design only for V1.
V1 is the foundation of a larger survival ecosystem.
