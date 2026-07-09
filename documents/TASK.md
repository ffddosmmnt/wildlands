Project: Wildlands Survival RPG V1
A single-player survival RPG inspired by Durango: Wild Lands.
The goal is NOT to recreate an MMO. The goal is to capture the core systems:
• Deep crafting
• Material properties
• Skill progression through usage
• Creature ecosystem
• Exploration
• Preparation-based combat
Target platform: Desktop first.
Engine: Godot 4.
Camera: Fixed isometric.
Rendering philosophy: Hybrid optimized rendering:
• Characters: 3D
• Creatures: 3D
• Weapons/tools: 3D
• Vegetation: billboard/impostor sprites
• Buildings: sprite/impostor when possible

───

Core Development Rule
DO NOT build content first.
Build SYSTEMS first.
A new item, tree, creature, weapon, or resource should be added through data files, not new code classes.
Prefer:
Create new JSON/resource entry
over:
Create new inherited class.

───

Phase 0: Project Foundation
Create clean architecture.
Folder structure:
/core /database /events /save
/entities /player /creature /resource_node
/systems /inventory /crafting /skill /combat /gathering
/data /items /recipes /creatures /resources /skills
/world /island /biomes
/ui /components

───

Phase 1: Data System
Create universal game object database.
Everything should have:
id name description tags properties
Example:
Resource: tree_acacia
Base: tree
Properties: health hardness biome drop_table

───

Phase 2: Material System
Create Durango-inspired material logic.
Materials are NOT simple items.
Every material contains attributes.
Example:
Bone:
Properties:
• hardness
• density
• sharpness
• weight
• quality
Wood:
Properties:
• hardness
• flexibility
• weight
Leather:
Properties:
• toughness
• flexibility
• thickness
Different sources modify properties.
Example:
Raptor Bone: base = Bone
modifier:
• sharpness
• weight
Large Dinosaur Bone: base = Bone
modifier:
• hardness
• density
• weight

───

Phase 3: Inventory System
Create item instances.
Important:
Two items with the same ID can have different stats.
Example:
Raptor Bone A
quality: 40
sharpness: 55
Raptor Bone B
quality: 80
sharpness: 90
Inventory must store unique item instances.

───

Phase 4: Crafting System
Create flexible recipe system.
Avoid fixed recipes.
Bad:
Iron + Wood = Sword
Good:
Sharp material + Handle material = Tool
Example:
Spear Recipe:
Requires: 1x sharp_material 1x handle_material
Calculate result:
damage = sharpness * 0.7 + hardness * 0.3
durability = density + material_quality
The crafting system creates unique equipment.

───

Phase 5: Skill Progression
Implement learn-by-doing system.
No traditional EXP farming.
Skills:
Gathering Hunting Crafting Cooking Survival
Actions produce experience.
Examples:
Cut tree:
• gathering XP
Create spear:
• crafting XP
Defeat creature:
• hunting XP
Higher skill unlocks:
• efficiency
• recipes
• success chance

───

Phase 6: World Prototype
Create one island.
Biome:
Tropical Forest
Required resources:
Trees:
• basic tree
• hardwood tree
Stone:
• common stone
• sharp stone
Plants:
• fiber plant
• food plant
Animals:
• passive herbivore
• aggressive small predator
• large predator

───

Phase 7: Creature System
Create base creature entity.
Properties:
species health speed size diet behavior drops
Behavior types:
Passive: Avoid player.
Defensive: Attack when threatened.
Aggressive: Hunt player.
Required V1 creatures:
Small herbivore
Medium predator
Large predator

───

Phase 8: Combat System
Inspired by Durango combat.
Combat philosophy:
Preparation > reaction.
Player power comes from:
• equipment
• preparation
• knowledge
• positioning
Implement:
Stats:
Health Stamina Attack Defense
Weapon types:
Spear:
• range
• safety
Knife:
• speed
• gathering bonus
Heavy weapon:
• damage
• speed
Creature combat:
Creature has:
Attack pattern Aggression range Weakness

───

Phase 9: Survival System
Implement simple survival.
Needs:
Hunger
Energy
Effects:
Hungry: lower stamina regeneration
Low energy: lower gathering efficiency
Avoid complex survival simulation in V1.

───

Phase 10: Base System
Create basic camp.
Required:
Campfire
Storage
Crafting station
No building system expansion yet.

───

Phase 11: First Playable Goal
The first release is successful when:
Player can:
1. Spawn on island.
2. Gather wood and stone.
3. Craft first tool.
4. Improve skill.
5. Hunt creature.
6. Use creature material.
7. Craft better equipment.
8. Fight stronger creature.
9. Upgrade camp.
Expected gameplay length:
30-60 minutes.

───

DO NOT IMPLEMENT YET
Save for future versions:
Multiplayer
Trading
NPC economy
Advanced taming
Breeding
Large world generation
Multiple islands
Weather simulation
Story campaign

───

Development Priority
System depth first.
Content amount second.
Graphics last.
A working system with cubes is better than a beautiful world without progression.
