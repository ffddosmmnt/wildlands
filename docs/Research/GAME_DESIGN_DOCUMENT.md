# WILDLANDS — Game Design Document
## Multiplayer Survival MMO Based on Durango: Wild Lands

**Project:** Wildlands  
**Genre:** Multiplayer Survival MMORPG  
**Platform:** Godot Engine (Mobile-First)  
**Target Audience:** Survival MMO and dinosaur game enthusiasts  
**Status:** V1 MVP Development  
**Last Updated:** July 10, 2026  
**Core Reference:** Durango: Wild Lands (Nexon, 2019)

---

## 1. CORE VISION

**The Time Warp Premise:**  
Players are thrust into a land where a temporal anomaly has merged creatures from different geological eras—Permian through Cenozoic periods coexist. Survivors from various time periods (21st century, 19th century, Roman, Medieval, etc.) must adapt and thrive together through cooperation and ingenuity.

**The Player's Journey:**  
- **Day 1-3:** Survive the warp, learn basic gathering and crafting through tutorial.
- **Week 1:** Choose an occupation, specialize in survival skills, build your first domain.
- **Month 1:** Establish clan connections, hunt dinosaurs, participate in island politics.
- **Ongoing:** Navigate competing factions, tame creatures, build settlements, achieve mastery.

**Key Design Philosophy:** Every progression system—occupational specialization, skill advancement, creature bonding, domain building—ties players together through interdependence and cooperation.

---

## 2. DESIGN PILLARS (DURANGO CORE)

### 1. **Desire-Based AI & Living Ecosystem**
- Animals act based on internal states: hunger, thirst, sleep, reproduction.
- Herbivores gather at water when thirsty, hunt for food when hungry.
- Carnivores actively hunt when hungry, rest when satisfied.
- Population dynamics respond to player hunting pressure.
- World feels alive, not static or scripted.

### 2. **Occupation-Based Interdependence**
- 8 occupations with complementary specialties (soldier, engineer, farmer, etc.).
- No player can be self-sufficient—cooperation is mandatory.
- Economies emerge from occupation supply/demand.
- Clans succeed through diverse skill distribution.
- Social bonds form through material/skill trading.

### 3. **Learn-by-Doing Skill Progression (RuneScape Model)**
- Every action levels related skills (grinding is meaningful).
- Combat skill → hit more often, unlock new moves.
- Gathering skill → collect more resources per action.
- Crafting skill → craft better items, unlock recipes.
- No experience system; only action-based learning.
- Skills are permanent (can unlearn 20 points/day for reallocation).

### 4. **Multi-Era Civilization Building**
- Players from different time periods → cultural clash/cooperation.
- Multiple factions with opposing ideologies compete for influence.
- Career Guide progression unlocks new content.
- T-Stone currency system enables trading across eras.
- Base building and domain management are core activities.

### 5. **Creature Bonding & Taming**
- Dinosaurs are partners, not just loot piñatas.
- Taming creates emotional bonds (lifespan matters).
- Pets actively fight alongside player in combat.
- Creatures age and can die (30-day lifespans create attachment).
- Riding systems change traversal and combat dynamics.

---

## 3. CORE GAMEPLAY LOOP (DURANGO MODEL)

```
WARP ARRIVAL
    ↓
TUTORIAL (gather, cook, craft, combat basics)
    ↓
CHOOSE OCCUPATION (soldier, farmer, engineer, etc.)
    ↓
ESTABLISH DOMAIN (build shelter, workspace on tamed island)
    ↓
SPECIALIZATION CYCLE:
    Gather → Craft (using occupation skills) → Hunt → Tame → Build
    ↓
FACTION ENGAGEMENT (align with company, forum, coalition, etc.)
    ↓
CLAN FORMATION (recruit players with complementary skills)
    ↓
UNSTABLE ISLAND EXPEDITIONS (higher risk, rare materials, aggressive dinosaurs)
    ↓
REPEAT (progression through career guide, skill tiers, faction quests)
```

### Loop Mechanics

**Phase 1: Exploration & Gathering**
- Player ventures into biome with current gear.
- Harvests resources (plants, stones, bones, hides).
- Encounters creatures (weak ones flee, strong ones attack).
- Maps safe routes and resource locations.

**Phase 2: Resource Management**
- Inventory is limited (forces strategic carrying).
- Different materials serve different purposes.
- Rarity creates progression milestones.

**Phase 3: Crafting & Preparation**
- Convert gathered materials into tools/gear.
- Recipes require specific combinations (material-gated).
- Station-based crafting (workbench, forge, etc.).
- Preparation for next hunt is deliberate.

**Phase 4: Hunting & Combat**
- Armed with better gear, player hunts stronger prey.
- Combat is tactical: positioning, stamina, creature behavior.
- Victory yields high-tier materials.
- Defeat → respawn at base with gear intact (permadeath avoided).

**Phase 5: Progression Loop**
- New materials unlock new recipes.
- New recipes enable new playstyles.
- Stronger creatures become huntable.
- Cycle repeats at higher difficulty.

---

## 4. PROGRESSION SYSTEM

### Tier Structure (Durango-Inspired)

**Tier 1: Primitive**
- Hand tools, stone weapons, leather armor.
- Resources: Wood, stone, basic plants, small animal hides.
- Creatures: Herbivores, small predators.
- Goal: Survive and establish base.

**Tier 2: Early Game**
- Bronze/copper tools, hide armor, basic shields.
- Resources: Metal ores, advanced plants, medium hides.
- Creatures: Pack hunters, mid-size predators.
- Goal: Establish crafting infrastructure.

**Tier 3: Mid Game**
- Iron tools, beast plate armor, crafted weapons.
- Resources: Rare ores, boss materials, exotic plants.
- Creatures: Large predators, boss-tier creatures.
- Goal: Hunt apex creatures.

**Tier 4: End Game (V1 Conclusion)**
- Masterwork equipment, specialized builds.
- Resources: Legendary materials, rare drops.
- Creatures: Apex predators, rare variants.
- Goal: Defeat the island's apex creature; achieve mastery.

### Skill-Based Progression (Not Experience Points)

**Combat Skills:**
- **Melee Proficiency**: Increases damage, reduces stamina cost (gain by hitting enemies).
- **Blocking**: Reduces incoming damage (gain by blocking hits).
- **Creature Knowledge**: Learn patterns of specific creatures (gain by fighting each type).

**Gathering Skills:**
- **Harvesting**: Yield 10% more resources per level (gain by gathering).
- **Tracking**: Spot creatures/resources on minimap (gain by exploring).
- **Tool Mastery**: Use special tool actions (gain by crafting).

**Survival Skills:**
- **Cooking**: Better food buffs, longer lasting (gain by cooking).
- **Stamina**: Larger stamina pool (gain by running/dodging).
- **Health**: Larger max HP (gain by taking/healing damage).

---

## 5. CRAFTING & ECONOMY SYSTEM

### Core Principle: Materials Drive Everything

**Resource Categories:**

1. **Structural Materials**
   - Wood, stone, clay
   - Used for: tools, building, furniture
   - Rarity: Common (unlimited respawn)

2. **Biological Materials**
   - Hide, sinew, bone, scales
   - Used for: armor, bindings, structural
   - Rarity: Uncommon (creature-dependent)

3. **Refined Materials**
   - Copper, iron, bronze (smelted from ore)
   - Used for: weapons, armor, tools
   - Rarity: Rare (ore deposit limited)

4. **Exotic Materials**
   - Boss drops, rare plants, minerals
   - Used for: high-tier gear, special items
   - Rarity: Very rare (boss-dependent)

### Crafting Stations (Durango Parallel)

| Station | Purpose | Tier 1 | Tier 2 | Tier 3+ |
|---------|---------|--------|--------|---------|
| **Workbench** | Basic tools, simple items | ✓ | — | — |
| **Forge** | Metal gear | — | ✓ | ✓ |
| **Tannery** | Armor processing | — | ✓ | ✓ |
| **Alchemy Lab** | Potions, buffs | — | — | ✓ |
| **Enchanter** | Special effects | — | — | ✓ |

### Recipe Philosophy

**No Padding Recipes:**
- Every recipe has purpose.
- No fluff items.
- Crafting chains are short (2-3 steps max).

**Example Crafting Chain:**
```
Stone Ore → Smelted Copper (Forge) → Copper Ingot
Copper Ingot + Wood → Copper Axe (Forge)
Copper Axe → Harvest hardwood faster
Hardwood + Copper + Hide → Copper-Reinforced Armor
```

**Rarity & Progression:**
- Tier 1: 1-2 ingredient recipes.
- Tier 2: 2-3 ingredient recipes.
- Tier 3: 3-4 ingredient recipes + rare materials.

---

## 6. COMBAT SYSTEM

### Philosophy: Tactical, Not Action-Focused

Combat succeeds when:
- Preparation matters (gear choice).
- Positioning matters (environment).
- Creature behavior matters (learning patterns).
- Stamina management matters (resource scarcity).

### Combat Loop

1. **Engagement**: Spot creature → approach with caution.
2. **Assessment**: Observe attack patterns, assess threat level.
3. **Action**: Attack, dodge, block, or retreat.
4. **Resource Management**: Monitor stamina, health, durability.
5. **Resolution**: Victory (loot) or retreat (regroup).

### Enemy Archetypes (Durango-Inspired)

| Type | Behavior | Weakness | Loot |
|------|----------|----------|------|
| **Herbivore** | Flees on sight | Speed-based | Hide, bone |
| **Pack Hunter** | Coordinates attacks | Fire, tools | Fang, hide |
| **Territorial** | Charges when threatened | Ranged attacks | Plate, ore |
| **Apex** | Intelligent tactics | Preparation & skill | Legendary drops |
| **Boss** | Unique patterns | Specific strat | Rare materials |

### Stamina & Resources

- **Stamina Bar**: Limits actions (attack, dodge, run).
- **Durability**: Weapons/armor degrade, requiring repairs.
- **Health Potions**: Rare, require ingredients to craft.
- **Escape Routes**: Always available (via stamina management).

---

## 7. WORLD & BIOME STRUCTURE

### Island Layout (Single Landmass)

**Design Goal:** Small but complete survival experience.  
**Scale:** 1-2 hours to traverse biome-to-biome.  
**Connectivity:** All biomes accessible, but progression gates based on gear.

### Biome Types (Durango Reference)

| Biome | Visual Style | Resources | Creatures | Challenges |
|-------|--------------|-----------|-----------|------------|
| **Grassland** | Open plains, scattered trees | Wood, stone, herbs | Herbivores, pack hunters | Exposure, heat |
| **Forest** | Dense vegetation, canopy | Hardwood, rare plants, bones | Ambush predators | Visibility, disease |
| **Mountain** | Rocky terrain, caves | Ore deposits, gems, metals | Territorial beasts | Fall damage, extreme cold |
| **Coast** | Beach, tidal zones, caves | Shells, algae, special fish | Crabs, seals, sharks | Drowning, tide zones |
| **Swamp** | Marsh, shallow water, logs | Mud, rare herbs, venom sacs | Reptiles, poisonous creatures | Poison, bog mire |

### Environmental Mechanics

- **Day/Night Cycle**: Some creatures nocturnal, visibility changes.
- **Weather**: Rain (slippery terrain), storms (visibility, danger).
- **Seasons** (V2+): Affects resource availability, creature behavior.
- **Environmental Damage**: Cold/heat, poison, drowning (avoidable with prep).

---

## 8. PLAYER PROGRESSION PACING

### V1 Target Story Arc

**Act I: Arrival (1-2 hours)**
- Washed ashore with nothing.
- Gather basic resources (wood, stone).
- Craft first stone tools.
- Build base and storage.
- Goal: Survive first day.

**Act II: Adaptation (3-5 hours)**
- Explore grassland, learn patterns.
- Hunt herbivores, gather hides.
- Craft leather armor, copper tools.
- Establish gathering routes.
- Goal: Feel competent in one biome.

**Act III: Mastery (5-8 hours)**
- Explore new biomes with basic gear.
- Hunt stronger creatures, gather rare materials.
- Craft better weapons and armor.
- Defeat a mini-boss.
- Goal: Prove dominance through preparation.

**Act IV: Apex (8-12 hours)**
- Hunt the island's apex creature.
- Assemble ultimate gear loadout.
- Execute planned strategy against boss.
- Victory = game conclusion.
- Goal: Complete the survival arc.

---

## 9. DESIGN CONSTRAINTS & RULES

### Architecture Rules (Protect Scalability)

✓ **DO:**
- Data-driven item definitions.
- Reusable component systems.
- Tier-based progression gates.
- Modular crafting recipes.

✗ **DON'T:**
- Hardcode creature stats.
- Creature-specific systems.
- Weapon-specific behaviors.
- Temporary hacks for edge cases.

### Content Pacing Rules

- No infinite content (no procedural generation).
- All content hand-crafted and tested.
- 10-15 hours = complete experience.
- Quality > quantity.

### Gameplay Rules (Protect Identity)

- Player never randomly stronger (only through grind).
- Equipment choice always matters.
- Preparation beats reflexes.
- Death has consequences (time lost, not progress).

---

## 10. V1 SUCCESS CRITERIA

**Gameplay Feel:**
- [ ] Player feels weak initially, gradually becomes competent.
- [ ] Gear upgrades feel meaningful.
- [ ] Enemy encounters feel tactical, not arbitrary.
- [ ] Survival loop is engaging for 10+ hours.

**Systems:**
- [ ] Crafting recipes scale with progression tiers.
- [ ] Skill system tracks learning progression.
- [ ] Biome transitions feel distinct.
- [ ] No game-breaking bugs or edge cases.

**Content:**
- [ ] 5+ biomes with unique visuals and creatures.
- [ ] 30+ recipes spanning 3 tiers.
- [ ] 10+ distinct creature types.
- [ ] 1 apex creature as end goal.

---

## 11. REFERENCE & INSPIRATION

**Durango: Wild Lands Mechanics:**
- Material-driven crafting economy.
- Skill-based progression (not XP).
- Tactical combat with preparation focus.
- Biome-specific resources and threats.
- Living ecosystem (creatures with behaviors).

**Design Philosophy Applied:**
- Systems first, content second, visuals last.
- Scalable architecture for future expansions.
- Data-driven design for rapid iteration.
- Clear separation of logic and presentation.

---

## 12. FUTURE EXPANSION HOOKS (Post-V1)

- Multiple islands with fast travel.
- NPC settlements and trade.
- Multiplayer (cooperative survival).
- Seasonal events and creature variants.
- Dungeon/cave systems with loot depth.
- Pet/companion systems.
- Base building and crafting automation.

---

## APPENDIX: QUICK REFERENCE

### Core Loop in One Sentence
Explore biome → gather materials → return to base → craft better gear → hunt stronger creatures → repeat with higher tier.

### The 5 Pillars
1. Preparation-based survival
2. Material-driven crafting
3. Learn-by-doing progression
4. Meaningful exploration
5. Living ecosystem

### Success Feels Like
"I arrived weak, learned the island's patterns, crafted smarter gear, hunted an apex creature, and mastered my environment."

---

**Document Owner:** Technical Director  
**Last Reviewed:** July 10, 2026  
**Next Review:** After Alpha Milestone
