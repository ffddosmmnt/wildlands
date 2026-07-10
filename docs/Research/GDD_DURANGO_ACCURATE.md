# WILDLANDS — Game Design Document
## Multiplayer Survival MMORPG Based on Durango: Wild Lands

**Project:** Wildlands  
**Genre:** Multiplayer Survival MMORPG  
**Platform:** Mobile (iOS/Android via Godot)  
**Target Audience:** Survival MMO, dinosaur game, sandbox community players  
**Status:** V1 MVP Development  
**Last Updated:** July 10, 2026  
**Foundation:** Durango: Wild Lands (NEXON, 2019)

---

## 1. CORE PREMISE & NARRATIVE

### The Time Warp Incident

Players begin their story when a mysterious temporal anomaly disrupts a passenger train, warping survivors to an island where creatures from multiple geological eras coexist:
- **Permian Period** creatures (ancient reptiles)
- **Mesozoic Era** (dinosaurs, pterosaurs)
- **Cenozoic Period** (large mammals, saber-tooths)

**Time Paradox:** Not only creatures exist across eras—survivors do too. Players encounter:
- 21st-century civilians
- 19th-20th century pioneers
- Roman centurions
- Medieval crusaders
- Ancient civilizations from various cultures

This creates a **multi-era, multi-cultural** survival setting where cooperation across time is mandatory.

### Story Throughline

**Act I: Arrival & Orientation (Hours 0-5)**
- Warp event, tutorial crash course in gathering/crafting/combat.
- Learn that you're stranded on an island with no way home.
- Realize survival requires adaptation and community.

**Act II: Settlement & Specialization (Hours 5-30)**
- Establish domain on a Tamed Island (safe, stable).
- Choose your occupation (defines your role in society).
- Join a clan or faction to pursue common goals.
- Discover competing factions with different ideologies.

**Act III: Exploration & Faction Politics (Hours 30+)**
- Venture to Unstable Islands for rare resources.
- Engage in faction quests that shape island politics.
- Form alliances with other clans.
- Participate in emergent gameplay (PvP on Savage Islands, if chosen).

---

## 2. DESIGN PILLARS

### Pillar 1: Desire-Based Ecosystem

**Animals are Simulation, Not Scripts**

Every creature has internal states:
- **Hunger:** When hungry → seeks food.
- **Thirst:** When thirsty → gathers at water.
- **Fatigue:** When tired → rests, ignores players.
- **Reproduction:** Seasonal breeding changes population.
- **Territory:** Creatures defend home areas.

**Emoticon System:**
Animals display emoticons showing their state (anger, joy, fear, sleepiness, surprise, thirst). Players read these to predict creature behavior.

**Example Scenario:**
- A herbivore grazes peacefully (happy emoticon).
- Player approaches → creature shows fear emoticon.
- Creature flees if escape route exists.
- Creature charges if cornered (anger emoticon).

This creates **predictable but dynamic** wildlife, where player preparation and reading animal cues determines success.

### Pillar 2: Occupation-Based Interdependence

**No Solo Progression**

Eight occupations form an interdependent economic system:

| Occupation | Specialization | Contribution |
|-----------|-----------------|--------------|
| **Soldier** | Combat, melee weapons | Defense, hunting |
| **Engineer** | Crafting bows, crossbows, ranged weapons | Supply weapons, DPS |
| **Farmer** | Cultivation, crop growth, food production | Sustenance, buffs |
| **Homemaker** | Cooking, food recipes, buffs | Pre-battle preparation, morale |
| **Attendant** | Tailoring, armor crafting, bags | Equipment, inventory expansion |
| **Office Worker** | Building, construction, structures | Base infrastructure |
| **Job Seeker** | Defense skills, shields, defensive tools | Survivability, tanking |
| **Student** | Gathering, resource collection | Raw materials |

**Economic Model:**
- Clan needs all 8 occupations to function optimally.
- Soldiers need weapons (Engineers) and armor (Attendants).
- Farmers need builders (Office Workers) for farm infrastructure.
- Cooking buffs require gathered ingredients (Students).
- Crafting chains connect occupations (Engineer needs raw materials from Student).

**Player Agency:**
- One player can train multiple occupations.
- But mastering all 8 requires impossible grinding.
- Clans succeed by recruiting diverse specialists.
- Trade and bartering become central gameplay.

### Pillar 3: Learn-by-Doing Progression (RuneScape Model)

**Action = Skill Advancement**

No experience points. Skills grow through repetitive use:

**Combat Skills:**
- Melee Proficiency: Levels by hitting enemies with weapons.
- Ranged Proficiency: Levels by firing projectiles.
- Defense: Levels by blocking/dodging incoming attacks.
- Creature Knowledge: Levels by fighting each species (tracks per-creature).

**Gathering Skills:**
- Foraging: Levels by harvesting plants.
- Mining: Levels by extracting ore.
- Fishing: Levels by catching fish.
- Hunting: Levels by slaying creatures.

**Crafting Skills:**
- Weapon Crafting: Levels by making weapons.
- Armor Crafting: Levels by making armor.
- Cooking: Levels by preparing food.
- Building: Levels by constructing structures.
- Tailoring: Levels by sewing garments.

**Skill Rewards:**
- Melee Proficiency +10 → +2% damage per level.
- Foraging +10 → +20% resource yield.
- Building +10 → unlock complex structures.

**Skill Flexibility:**
- Unlearn 20 skill points per day (respec system).
- Allows occupation switching without rerolling character.
- Encourages experimentation and adaptation.

### Pillar 4: Multi-Era Civilization

**Players Build Society**

Domains are player-built settlements on Tamed Islands. Infrastructure includes:
- **Homes** (personal shelter, storage).
- **Workstations** (occupation-specific crafting benches).
- **Fortifications** (walls, towers, defensive structures).
- **Communal Spaces** (gathering halls, markets).
- **Farms** (food production infrastructure).

**Factions Shape Island Politics:**

1. **The Company** — Humanitarian rescue organization. Focus: saving survivors.
2. **Chlorophyll Forum** — Environmentalists. Focus: preserve nature, sustainable living.
3. **Frontier Coalition** — Industrialists. Focus: technology, progress, T-Stone economy.
4. **The Committee** — Mysterious. Focus: unknown (hidden agenda).
5. **Radio University** — Educators led by Dr. Lamar. Focus: knowledge, skill training.

Players align with factions through quest choices, unlocking faction-specific items and storylines.

### Pillar 5: Creature Bonding & Taming

**Dinosaurs as Companions, Not Loot**

**Taming Mechanics:**
- Capture creatures using taming herbs and pens.
- Bond with creature over time (lifespan: ~30 days).
- Creatures develop attachment, fight harder when bonded.
- Creature aging (after 30 days, stats decline unless treated).
- Anti-aging remedies extend lifespan.

**Companion System:**
- Tamed dinosaur follows player like a pet.
- Automatically joins combat (deals damage based on level/type).
- Can be ridden (changes movement speed, combat positioning).
- Multiple dinosaurs = multiple inventory slots.
- Death of beloved pet creates emotional consequence.

**Strategic Depth:**
- Herbivore companions: Lower combat power, better resource gathering.
- Carnivore companions: Higher combat power, lower gathering help.
- Rare creatures: Unique abilities and personalities.
- Player bonding affects creature behavior (happy vs. angry dinosaur).

---

## 3. ISLAND SYSTEM (CORE PROGRESSION STRUCTURE)

### Island Types

**Tamed Islands (Safe, Starter)**
- Stable terrain, no disappearance.
- Ideal for domain building.
- Lower-tier creatures (easier hunting).
- Renewable resources (respawn quickly).
- Perfect for beginners learning survival skills.
- Example: Coastal Valley, Grassland Plains.

**Civilized Islands (Stable, Mid-Game)**
- Require T-Stone payment to maintain domain.
- More resources than Tamed, but riskier.
- Mix of tier 1-2 creatures.
- Good for clan hubs (coordinated bases).
- Contested territory (PvP possible but limited).

**Unstable Islands (Dangerous, End-Game)**
- Appear and disappear randomly (environmental hazard).
- Highest-tier creatures and rare resources.
- No permanent bases (prevents camping).
- Multiple expeditions needed (exploration gameplay).
- Requires preparation and teamwork.
- Example: Volcanic Peak, Frozen Wastes, Primordial Jungle.

**Savage Islands (Lawless, PvP-Focused)**
- No rules, no protection from other players.
- Extreme resources and apex creatures.
- Permadeath consequences (optional hardcore mode).
- Clan warfare encouraged.
- Not mandatory to engage (opt-in difficulty).

### Domain System

**Personal Settlements**

Players claim land on Tamed/Civilized islands to build domains:
- **Plot Size:** Varies by progression level (more advanced = larger).
- **Building Slots:** Limited number (encourages prioritization).
- **Workstations:** Occupation-specific (forge, loom, farm, etc.).
- **Storage:** Chest capacity (limited inventory, encourages logistics).
- **Defense:** Walls, towers, traps (protection against wild creatures, optional PvP).
- **Decorations:** Personal expression, no gameplay effect.

**Domain Progression:**
- Tier 1: Single dwelling, 1-2 workstations.
- Tier 2: Small compound, 4-6 workstations, defensive walls.
- Tier 3: Full settlement, 8-12 workstations, fortified.

---

## 4. CHARACTER PROGRESSION & OCCUPATIONS

### Starting the Game

**Character Creation:**
1. Select Survivor Type (visual appearance, era backstory).
2. Choose Backstory (gives +20 bonus to one occupation skill).
3. Select Starting Occupation (+20 skill boost, not locked).
4. Name character and enter world.

### Eight Occupations (Detailed)

**Soldier**
- Starting Skill Bonus: Melee weapons (+20 attack).
- Specialization: Combat, hunting, tanking.
- Unique Abilities: Special combat moves, dual-wielding.
- Role in Clan: Primary hunters, defenders.
- Progression: Unlocks stronger weapon types.

**Engineer**
- Starting Skill Bonus: Bow/crossbow crafting (+20).
- Specialization: Ranged weapons, precision.
- Unique Abilities: Explosive bolts, trap-making.
- Role in Clan: Supply weapons, enable ranged hunts.
- Progression: Unlocks compound bows, special ammunition.

**Farmer**
- Starting Skill Bonus: Cultivation (+20).
- Specialization: Food production, agriculture.
- Unique Abilities: Faster crop growth, selective breeding.
- Role in Clan: Provides sustenance for large clans.
- Progression: Unlocks rare crops, medicinal plants.

**Homemaker**
- Starting Skill Bonus: Cooking (+20).
- Specialization: Food recipes, pre-hunt buffs.
- Unique Abilities: Stat-boosting meals, potion brewing.
- Role in Clan: Enhances hunter power before expeditions.
- Progression: Unlocks powerful buff recipes.

**Attendant**
- Starting Skill Bonus: Tailoring (+20).
- Specialization: Armor crafting, fashion.
- Unique Abilities: Custom armor variants, bag expansion.
- Role in Clan: Provides gear, increases inventory.
- Progression: Unlocks exotic armor types.

**Office Worker**
- Starting Skill Bonus: Building (+20).
- Specialization: Construction, infrastructure.
- Unique Abilities: Faster building, defensive structures.
- Role in Clan: Builds domain infrastructure, fortifications.
- Progression: Unlocks advanced building types.

**Job Seeker**
- Starting Skill Bonus: Defense skills (+20).
- Specialization: Tanking, shield use, blocking.
- Unique Abilities: Defensive stances, damage reduction.
- Role in Clan: Primary tank, frontline combat.
- Progression: Unlocks rare shields, defensive abilities.

**Student**
- Starting Skill Bonus: Gathering (+20).
- Specialization: Resource collection, foraging.
- Unique Abilities: Larger gathering yields, rare find detection.
- Role in Clan: Primary resource supplier.
- Progression: Unlocks detection of hidden resource nodes.

### Skill Tree & Advancement

**Flexible Progression:**
- Players are NOT locked to their starting occupation.
- Skill points earned from actions can be spent on any skill.
- Backstory bonus (+20) is just a head start.
- Player agency: Become whatever you want.

**Career Guide (Progression Gates):**
- Quest-based progression separate from skills.
- Unlocks new craftable items, areas, abilities.
- Paced story content alongside skill grinding.
- Different path for each occupation.

**Skill Capping (Post-V1 Feature):**
- Soft caps to prevent total dominance.
- Still possible to master multiple occupations (takes time).
- Encourages specialization without forcing it.

---

## 5. FACTIONS & EMERGENT GAMEPLAY

### Five Factions (Player Agency)

**The Company (Humanitarian)**
- Mission: Rescue new Warp survivors, provide humanitarian aid.
- Quests: Rescue missions, resource donations, sanctuary building.
- Rewards: Unique rescue gear, humanitarian prestige.
- Playstyle: Cooperative, community-focused.
- Conflict: Opposes Committee's secrecy, Coalition's industrialization.

**Chlorophyll Forum (Environmentalist)**
- Mission: Preserve Durango's ecosystem, prevent exploitation.
- Quests: Animal protection, nature restoration, sanctuaries.
- Rewards: Eco-friendly tools, creature empathy bonuses.
- Playstyle: Conservation, balance, harmony.
- Conflict: Opposes Coalition's industrial push.

**Frontier Coalition (Industrialist)**
- Mission: Accelerate technological progress, establish T-Stone economy.
- Quests: Mining operations, factory construction, trade routes.
- Rewards: Advanced gear, T-Stone discounts, industrial tools.
- Playstyle: Progress-driven, competitive, resource-focused.
- Conflict: Opposes Forum's environmental restrictions, Company's charity.

**The Committee (Mysterious)**
- Mission: Unknown (shape Durango's fate from shadows).
- Quests: Hidden, cryptic, discovery-based.
- Rewards: Unique/powerful items, hidden knowledge.
- Playstyle: Secretive, exploration-focused, power-seeking.
- Conflict: Opposes everyone (perceived as threat).

**Radio University (Educational)**
- Mission: Teach and guide survivors in Durango's ways.
- Quests: Skill training, knowledge quests, education.
- Rewards: Skill boosters, recipe unlocks, educational prestige.
- Playstyle: Learning-focused, tutorial support.
- Conflict: Neutral (serves all factions).

### Faction System Mechanics

**Faction Alignment:**
- Each action has faction consequence (help/hurt alignment).
- Quests can be completed for different factions (choice matters).
- Alignment affects prices, NPC reactions, access to areas.
- No faction lock-in (can switch, but lose progress with previous faction).

**Emergent Conflict:**
- Clans align with different factions (creates clan rivalry).
- Territory control quests (competing interests).
- Trade embargoes (faction members refuse to trade with enemies).
- Hidden agendas unfold through questlines.

---

## 6. MULTIPLAYER & SOCIAL SYSTEMS

### Clan System

**Clan Formation:**
- 2+ players create a clan (shared treasury, territory, goals).
- Clan ranks (leader, officer, member).
- Permission levels (who can build, withdraw funds, recruit).
- Up to 50+ members per clan (scales).

**Clan Benefits:**
- Shared domain territory on Civilized Islands.
- Collective workstations (shared crafting power).
- Treasury (shared T-Stones and resources).
- Clan quests (cooperative objectives).
- Clan wars (optional, against other clans).

### Cooperative Gameplay

**Party System:**
- Up to 4-8 players join a temporary party.
- Shared threat (creatures focus strongest player).
- Loot splitting (negotiable rolls or auto-divide).
- Downed rescue system (teammates can revive downed players).

**Rescue Mechanic:**
- Player downed → 5 min timer before respawn.
- Any player can revive (takes 30 sec, risky).
- Rescuer gets reward (experience, T-Stone).
- Encourages altruism and risk-taking.

**Trading System:**
- Direct player-to-player trades (with escrow).
- Marketplace auctions (community commerce).
- Prices set by supply/demand.
- Occupation-dependent pricing (Engineers' bows expensive, Farmers' crops cheap).

---

## 7. COMBAT SYSTEM (DURANGO-STYLE)

### Real-Time Combat with Automation

**Player Input:**
- Basic attacks: Automated (repeat pressing attack).
- Special abilities: Player-triggered (skill buttons).
- Defense button: Roll/block (timing-based, levels defense skill).
- Pet command: Summon/recall pet, strategic positioning.

**Automated Elements:**
- Basic attacks proceed automatically.
- Creatures use AI-based tactics.
- Movement partially automated (auto-pathing to target).

**Skill Button System:**
- Occupation-specific special moves.
- Soldier: Powerful charge attack, whirlwind spin.
- Engineer: Rapid fire, explosive shot.
- Job Seeker: Defensive stance, shield bash.
- Farmer: Crowd control, roots.

**Defense Mechanics:**
- Defense button provides dodge/block (active defense).
- Timing matters (early = no effect, perfect = full dodge).
- Defense skill levels through practice.
- Creature special attacks are telegraphed (player has time to react).

### Pet Combat

**Automatic Participation:**
- Tamed creature fights alongside player.
- Deals damage based on creature type/level.
- Can be targeted by enemies (pet defense is risky).
- Player can protect pet or sacrifice pet for safety.

**Strategic Depth:**
- Herbivore pets: Lower damage, higher defense.
- Carnivore pets: Higher damage, lower defense.
- Pet type matters for encounter success.
- Losing pet creates attachment loss (narrative consequence).

---

## 8. CRAFTING & ECONOMY (OCCUPATION-DRIVEN)

### Material-Based Economy

**Resources are Real:**
- Not infinite (respawn rates are balanced).
- Gathering is time-bottleneck (not instant).
- Crafting is quick (material gathering > crafting time).
- Storage is limited (logistics matter).

**Occupation-Specific Crafting:**

**Soldier → Uses weapons**
- Doesn't craft weapons (Engineer's job).
- Can craft ammunition, consumables.
- Prioritizes combat stats.

**Engineer → Crafts ranged weapons**
- Needs materials: Wood, metal, feathers.
- Recipes: Bow, crossbow, bolts, explosives.
- Economic power: Supply hunters with DPS gear.

**Farmer → Grows crops**
- Seeds, soil, water → vegetables, grains.
- Feeds clan, provides raw cooking materials.
- Economic power: Supply basic sustenance.

**Homemaker → Prepares meals**
- Raw ingredients → cooked dishes.
- Dishes grant temporary stat buffs (strength, speed, defense).
- Example: Roasted meat +10% attack for 30 min.
- Economic power: Enable hunters to hunt better.

**Attendant → Crafts armor**
- Needs materials: Hide, metal, thread.
- Recipes: Chest armor, leg armor, gloves, helmets.
- Economic power: Keep hunters alive longer.

**Office Worker → Constructs structures**
- Needs materials: Wood, stone, nails.
- Recipes: Homes, workstations, walls, towers.
- Economic power: Enable civilization building.

**Job Seeker → Crafts defensive gear**
- Needs materials: Metal, hide, reinforcements.
- Recipes: Shields, helmets, defensive artifacts.
- Economic power: Enable tanking, survival.

**Student → Gathers resources**
- Harvest wood, ore, plants, meat.
- Basic gathering operations (no crafting).
- Economic power: Resource supply foundation.

### T-Stone Currency (Post-Tamed Island)

**Introduction:**
- Frontier Coalition introduces T-Stone currency.
- Used for Civilized Island domain taxes.
- Enables cross-faction trading.
- Player-earned through activities (not microtransaction).

**Economy Balance:**
- T-Stones come from: Faction quests, creature loot, domain taxes.
- T-Stones spent on: Island taxes, rare recipes, cosmetics.
- Supply/demand sets prices.
- Inflation possible (monitored in live).

---

## 9. PROGRESSION PACING (DURANGO EXPERIENCE)

### Hour 0-5: Arrival & Tutorial

**Goals:**
- Learn gathering, crafting, basic combat.
- Build first shelter.
- Understand survival mechanics.
- Choose initial occupation.

**Feeling:**
- Overwhelming, learning curve.
- "I'm going to starve if I don't act fast."
- Rewarding when first tool is crafted.

### Hour 5-20: Specialization & Domain

**Goals:**
- Level occupation skills (5+ levels).
- Build functional domain (multiple workstations).
- First dinosaur taming.
- Join a clan.

**Feeling:**
- "I'm getting better at my job."
- "My clan is counting on me."
- "My domain is starting to look like home."

### Hour 20-50: Exploration & Factions

**Goals:**
- Explore multiple biomes.
- Join faction quests.
- Hunt tier 2 creatures.
- Participate in clan activities.

**Feeling:**
- "I'm discovering the world."
- "My choices matter (faction alignment)."
- "Clan warfare is getting real."

### Hour 50+: Mastery & Endgame

**Goals:**
- Unstable island expeditions.
- Apex creature hunts (legendary loot).
- Faction questline conclusions.
- Clan wars, territory control.

**Feeling:**
- "I'm a master of my occupation."
- "My clan is a force to be reckoned with."
- "There's always something new to explore."

---

## 10. V1 SUCCESS CRITERIA

**Content Completeness:**
- [ ] 5+ Tamed Island biomes (starting zones).
- [ ] 3+ Civilized Islands (mid-game).
- [ ] 2+ Unstable Islands (end-game).
- [ ] 50+ unique creatures (across eras).
- [ ] 200+ craftable recipes.
- [ ] 8 fully developed occupations.
- [ ] 5 factions with quest lines.

**System Quality:**
- [ ] Desire-based AI creatures behave consistently.
- [ ] Skill progression feels rewarding (visible improvement).
- [ ] Occupation interdependence forces cooperation.
- [ ] Pet bonding creates emotional attachment.
- [ ] Faction system creates meaningful choices.

**Gameplay Feel:**
- [ ] Tutorials teach effectively (new players don't overwhelm).
- [ ] Progression curves match skill difficulty.
- [ ] Clan gameplay enables social bonds.
- [ ] Unexpected emergent moments (AI behavior surprises).
- [ ] Multiple viable playstyles (not one "optimal" path).

**Technical:**
- [ ] Supports 50+ concurrent players on island.
- [ ] Creature AI doesn't lag servers.
- [ ] Mobile optimization (runs on mid-range phones).
- [ ] No game-breaking bugs.
- [ ] Clear communication (tooltips, tutorials).

---

## REFERENCE & INSPIRATION

**Durango: Wild Lands (2019, Nexon)**
- Desire-based creature AI (core innovation).
- Occupation-based interdependence.
- Time warp narrative (multi-era survivors).
- Island system (dynamic world progression).
- Pet bonding mechanics.
- Faction-based story branching.

**Design Lessons Applied:**
- Player cooperation > competition (occupations force it).
- Grinding should feel meaningful (learn-by-doing).
- Narrative matters (factions, storytelling, character agency).
- Emergent gameplay from systems (AI + player choice).
- Mobile-first design (Durango was mobile hit).

---

**Document Owner:** Technical Director  
**Last Updated:** July 10, 2026  
**Next Review:** After Alpha Milestone
