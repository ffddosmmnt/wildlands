# COMBAT & CREATURE DESIGN
## Desire-Based AI and Real-Time Combat (Durango: Wild Lands Model)

**Last Updated:** July 10, 2026  
**Version:** 2.0 (Durango-Accurate)  
**Core Innovation:** Desire-based animal simulation, pet bonding mechanics

---

## 1. COMBAT PHILOSOPHY (DURANGO-STYLE)

### Core Principle: Automated with Player Agency

Combat is **not an action game**, but allows meaningful player input:

**Automated Elements:**
- Basic attacks proceed automatically (holding attack button).
- Creature AI acts autonomously (based on desires, not scripts).
- Movement partially automated (navigation to target).
- Pet attacks independently (controlled positioning, not micro).

**Player Agency:**
- **Defense Button:** Roll/dodge/block (timing matters, levels Defense skill).
- **Special Abilities:** Occupation-specific (triggered manually, limited uses).
- **Pet Commands:** Summon, recall, aggressive/passive stance.
- **Positioning:** Walk to advantageous locations (ranged vs melee).
- **Equipment Choice:** Weapon/armor selection before fight.

### Combat Feel

**Early Game (Tier 1):**
- Creatures are slow, telegraphed.
- Player can button-mash and win.
- Defensive button rarely needed.
- Learning curve: Minimal.

**Mid Game (Tier 2):**
- Creatures have attack patterns.
- Defensive button timing matters (dodge or block).
- Wrong equipment → much harder (gear checks).
- Learning curve: Moderate (requires strategy).

**Late Game (Tier 3+):**
- Creatures are intelligent (adapt to player tactics).
- Defensive timing is critical (skill expression).
- Pet coordination essential (manage both fighters).
- Learning curve: Steep (mastery required).

---

## 2. DESIRE-BASED CREATURE AI (Core Innovation)

### Creature Internal States

Every creature has **desires** that drive behavior:

**Hunger**
- When hunger > threshold → actively hunts.
- Seeks food sources (weaker creatures, vegetation).
- Aggression level increases.
- Example: A predator sees you → hungry? Attacks. Fed? Ignores.

**Thirst**
- When thirst > threshold → seeks water.
- Travels to water regardless of player proximity.
- Non-aggressive during drinking (vulnerability window).
- Example: Herbivore sees water → walks directly toward it, ignoring player.

**Fatigue**
- When fatigue > threshold → seeks rest.
- Finds safe area and sleeps (3-5 min cycles).
- Cannot be awakened without damage.
- Example: Creature is tired → doesn't hunt, just rests.

**Reproduction**
- Seasonal mating drives behavior.
- Territorial during mating season (aggressive).
- Peaceful during non-mating (ignores player if possible).
- Example: Pack hunters are territorial during breeding → attack anything.

**Territory**
- Each creature has defined territory (1-5 minute walk radius).
- Will defend against intruders.
- Leaves territory only if chased far away (then returns).
- Example: Bear marks a mountain zone → attacks players entering, doesn't follow outside.

### Emoticon Display System

Creatures show emoticons revealing internal state:

| Emoticon | Meaning | Player Action |
|----------|---------|----------------|
| 😊 Happy | Satisfied, peaceful | Safe to pass |
| 😠 Angry | Threatened, aggressive | Prepare for fight |
| 😴 Sleepy | Tired, resting | Easy to sneak |
| 😨 Scared | Threatened, will flee | Back away slowly |
| 😋 Hungry | Actively hunting | High threat |
| 😤 Thirsty | Seeking water | Moving predictably |
| 😲 Surprised | Startled, brief stun | Attack window |

**Player Reading Emoticons:**
- Approaching creature with happy emoticon → likely to ignore you.
- Approaching creature with angry emoticon → prepare defense.
- Creature with thirsty emoticon → predictable path to water.
- Creature with sleepy emoticon → sneak past or attack easily.

This creates **predictable but dynamic** encounters where preparation and observation matter.

---

## 3. COMBAT MECHANICS (REAL-TIME, AUTOMATED)

### Attack Resolution

**Player Attack:**
1. Player holds attack button (or presses repeatedly).
2. Character swings weapon (animation plays ~0.5-1.0 sec).
3. Damage roll: Base damage ± 10% + equipped weapon bonus.
4. Hit detection: Creature dodges? Blocks? Takes damage?
5. Creature counter-attacks (AI-decided).

**Creature Attack:**
1. Creature decides to attack (desire-driven: hunger, territory, etc.).
2. Attack preparation: ~0.3-0.5 sec wind-up (telegraphed).
3. Player can dodge (Defense button, timing-based).
4. Damage application: Reduced if blocked, full if hit.

**Defense Mechanics:**
- **Dodge Roll:** Quick invulnerability window (~0.3 sec), uses stamina.
- **Block:** Reduces damage by 50%, uses stamina.
- **Perfect Dodge:** Zero damage if timed perfectly, levels Defense skill +2.
- **Failed Dodge:** Takes full damage, no skill gain.

### Stamina System (Resource Management)

**Stamina Pool:**
- Base: 100 stamina.
- Regenerates at rest: 10 stamina/sec.
- Regenerates in combat: 2 stamina/sec (slow).

**Stamina Costs:**

| Action | Cost | Notes |
|--------|------|-------|
| Light Attack | 15 | Quick swing |
| Heavy Attack | 30 | Slow, powerful |
| Dodge Roll | 20 | Invulnerability window |
| Block | 10 | Per hit |
| Sprint | 5/sec | Continuous drain |

**Stamina Depletion:**
- Out of stamina → cannot attack.
- Must wait 5-10 seconds for regeneration.
- Vulnerability window (creature attacks freely).
- Skill expression: Manage stamina, don't deplete.

**Creature Stamina:**
- Creatures also have stamina (feels fair).
- Large creatures deplete faster (lumbering attacks).
- Small creatures have less but regen faster.
- Player can exploit (tire creature out, counter-attack).

---

## 4. CREATURE TYPES & ARCHETYPE BEHAVIORS

### Archetype 1: Herbivore (Gathering Focus)

**Behavior Pattern:**
- Peaceful grazing (default state, happy emoticon).
- Fleeing (if threatened, scared emoticon).
- Territorial (during mating, only aggressive to own species).

**Combat Profile:**
- HP: 20-40 (low, dies quickly).
- Damage: 0-5 (very low, not a threat).
- Defense: 0 (no armor).
- Speed: 6-8 m/s (moderate, outrun-able on flat ground).

**Loot:**
- Hide (always drops, 1-3 qty).
- Meat (butcher on death, 5-10 qty).
- Bone (rare drop, 0-2 qty).

**Encounter Strategy:**
- Approach from behind (avoid spooking).
- Single hit → creature flees.
- Easy kill (testing combat mechanics).
- Minimal threat (use for skill grinding).

**Examples:** Deer, Boar, Ox, Camel, Stegosaurus (herbivore dinosaur).

---

### Archetype 2: Pack Hunter (Coordinated Predator)

**Behavior Pattern:**
- Hunting (active when hungry, aggressive emoticon).
- Coordinating (multiple creatures attack together).
- Following leader (leader's behavior influences pack).
- Fleeing (if leader dies or all injured).

**Combat Profile:**
- HP: 40-60 per creature.
- Damage: 10-15 per hit.
- Defense: 2-4 (some armor).
- Speed: 6-7 m/s (coordinated pack movement).
- Coordination: Attacks from multiple angles.

**Loot (Per Creature):**
- Hide (1-2 qty).
- Fang (leader drops rare, 0-1 qty).
- Meat (3-5 qty).
- Pack Essence (rare drop, special material).

**Encounter Strategy:**
- Locate leader (usually largest/most dominant).
- Focus fire on leader first (pack confidence drops).
- Use area attacks (separate pack formation).
- Back against terrain (limit flanking).
- Single vs. 3-4 creatures → very hard without prep.

**Examples:** Wolf Pack, Hyena Pack, Raptor Squad, Prehistoric Pack Predators.

---

### Archetype 3: Territorial (Aggressive Defender)

**Behavior Pattern:**
- Patrolling territory (walking marked path, neutral).
- Charging intruders (if player enters zone, angry emoticon).
- Defending young (extra aggressive if cubs present).
- Leaving territory (only if chased far away).

**Combat Profile:**
- HP: 70-100 (moderate, surviving creatures).
- Damage: 15-25 (high, threatening).
- Defense: 5-8 (armor-like hide).
- Speed: 4-6 m/s (powerful but slow).
- Charge Attack: Unavoidable first hit (player must dodge or block).

**Loot:**
- Rare Hide (1-2 qty, high value).
- Armor Plate (rare drop, special material).
- Meat (5-8 qty).
- Territory Token (unique, proves kill).

**Encounter Strategy:**
- Avoid territory if unprepared.
- If engaging: Prepare before entering.
- First charge is unavoidable (dodge/block only defense).
- Wear heavy armor (reduces charge damage).
- Area-of-effect abilities help.
- Never fight in its territory (lures backup creatures).

**Examples:** Bear, Big Cat, Rhinoceros, T-Rex, Territorial Dinosaurs.

---

### Archetype 4: Apex Predator (Intelligent Hunter)

**Behavior Pattern:**
- Intelligent hunting (learns player tactics mid-fight).
- Adapting tactics (changes strategy if current fails).
- Coordinating with kin (rare, apex pairs hunt together).
- Avoiding weakness (exploits player mistakes).

**Combat Profile:**
- HP: 100-150 (durable, multi-round fights).
- Damage: 20-30 (threatening, can kill players).
- Defense: 8-12 (difficult to damage).
- Speed: 7-8 m/s (fast, outpaced players).
- Intelligence: 8/10 (tactical awareness).

**Loot:**
- Rare Hide (2-3 qty, high value).
- Apex Core (unique, legendary material).
- Fangs/Claws (rare, weapon material).
- Essence Crystal (rare drop).

**Encounter Strategy:**
- Only engage with full prep (tier 3 gear minimum).
- Study patterns (first encounter usually a loss).
- Use environment (cliffs, water, fire).
- Coordinate with team (1v1 is extremely hard).
- Stamina management critical (creature learns your patterns).
- Never underestimate (adapts to your strategy).

**Examples:** Saber-tooth Tiger, Great Lion, Prehistoric Apex Hunters.

---

### Archetype 5: Boss/Unique (Narrative Encounter)

**Behavior Pattern:**
- Multi-phase combat (changes tactics between phases).
- Arena hazards (environment is second enemy).
- Story-driven (defeat = progression milestone).
- Unique mechanics (species-specific abilities).

**Combat Profile:**
- HP: 200-400 (must survive multiple rounds).
- Damage: 30-50 (extreme threat).
- Defense: 12-15 (very difficult to damage).
- Speed: 6-8 m/s (surprisingly fast).
- Intelligence: 10/10 (perfect tactical awareness).

**Loot:**
- Unique Item (gear named after boss).
- Legendary Materials (no respawn, one-time drop).
- Achievement (proof of victory).
- Questline Completion (story advancement).

**Encounter Strategy:**
- Completely optional (not mandatory for V1).
- Extreme preparation required.
- Full team needed (4-8 players recommended).
- Multiple attempts expected (learn patterns).
- Victory = game milestone (significant achievement).

**Examples:** Ancient Dragon, Great Leviathan, Prehistoric Apex, Time Warp Anomaly.

---

## 5. SPECIFIC CREATURE ROSTER (V1)

### Tier 1 (Beginner, Grassland/Forest)

| Creature | Type | HP | DMG | Loot | Purpose |
|----------|------|----|----|------|---------|
| Deer | Herbivore | 20 | 0 | Hide, bone | Skill teaching |
| Boar | Herbivore | 30 | 2 | Hide, meat | First hunt |
| Wolf (Solo) | Hunter | 40 | 12 | Hide, fang | Pack intro |
| Rabbit | Herbivore | 10 | 0 | Fur | Gathering |
| Small Predator | Hunter | 35 | 10 | Hide, bone | Combat intro |

### Tier 2 (Intermediate, Forest/Mountain)

| Creature | Type | HP | DMG | Loot | Purpose |
|----------|------|----|----|------|---------|
| Wolf Pack (3) | Hunter | 50 each | 14 | Rare fang | Coordination |
| Bear | Territorial | 80 | 18 | Plate, hide | Challenge |
| Saber Tiger | Apex | 100 | 22 | Rare hide, core | Skill check |
| Giant Boar | Territorial | 70 | 16 | Armor plate | Mid-boss |
| Crocodile | Territorial | 75 | 15 | Scales | Water hazard |

### Tier 3 (Advanced, Mountain/Unstable)

| Creature | Type | HP | DMG | Loot | Purpose |
|----------|------|----|----|------|---------|
| Apex Lion | Apex | 120 | 25 | Legendary mat | Skilled hunt |
| Basilisk | Apex | 110 | 23 | Venom sac | Poison mechanic |
| Pteranodon | Apex | 90 | 20 | Rare feathers | Airborne |
| T-Rex | Territorial | 150 | 30 | Huge loot | Boss threat |

### Tier 4 (Legendary, Boss Arena)

| Creature | Type | HP | DMG | Loot | Purpose |
|----------|------|----|----|------|---------|
| Ancient Dragon | Boss | 300 | 40 | Unique items | Game conclusion |
| Great Leviathan | Boss | 280 | 38 | Unique items | Alt boss |

---

## 6. PET TAMING & BONDING SYSTEM

### Taming Mechanics

**Requirements:**
- Taming herbs (fed to creature).
- Taming pen (structure, confines creature).
- Time investment (30 sec - 5 min, depends on creature).
- Risk (creature can break free, damage player).

**Taming Process:**
1. Capture creature in taming pen (herding or trapping).
2. Feed taming herbs until tamed (passive process).
3. Creature emoticon changes (anger → calm).
4. Successfully tamed (creature joins inventory as pet).

### Pet Bonding

**Lifespan:**
- Default: 30 days (real-time).
- After 30 days: Pet ages (stats decline by 10% per day).
- Anti-aging remedies: Extend lifespan (temporary).
- Pet death: Permanent loss (emotional consequence).

**Bonding Mechanics:**
- Pet follows player like a puppy.
- Daily interaction increases bond (feeding, petting).
- High bond = stronger combat performance (+10% damage).
- Low bond = weaker performance (-10% damage).
- Pet death with high bond = significant emotional loss.

**Combat Role:**
- Pet automatically joins combat.
- Deals 50-100% of creature's natural damage.
- Has own HP (can be targeted and killed).
- Can be recalled to prevent death (strategic choice).

### Strategic Implications

**Pet Type Matters:**
- **Herbivore Pets:** Weak combat, help with gathering, pack animals.
- **Carnivore Pets:** Strong combat, useless at gathering, hunting focus.
- **Rare Pets:** Unique abilities (flying, special senses, healing).

**Pet Mortality Creates Attachment:**
- 30-day lifespan means constant pet turnover (V1 pain point).
- Player forms emotional bond → pet death hurts.
- Incentivizes finding special anti-aging items.
- Post-V1: Permanent pets possible (different mechanics).

---

## 7. COMBAT ENCOUNTER DESIGN

### Encounter: Herbivore Herd (Tier 1)

**Setup:**
- 3-5 deer/boar grazing peacefully.
- Grassy plain, open visibility.
- No environmental hazards.

**Challenge:**
- Approach without spooking (stealth).
- One hit → herd flees.
- Can't catch fleeing creatures (chase futile).
- Success = kill one before they scatter.

**Lesson Taught:**
- Preparation beats reflexes (position before approaching).
- Weapon choice matters (spear vs. axe, different stun effects).
- Awareness required (read emoticons).

---

### Encounter: Wolf Pack (Tier 2)

**Setup:**
- 3 wolves, pack leader (largest).
- Forest clearing, medium visibility.
- Ambush possible (wolves hide, wait).

**Challenge:**
- 3v1 (overwhelming if unprepared).
- Coordinated attacks (pack flanks).
- Leader dies → pack morale breaks.
- Multiple rounds (stamina management critical).

**Lesson Taught:**
- Gear matters (armor reduces damage).
- Crowd control helps (area attacks separate pack).
- Focus fire strategy (kill leader first).
- Pet helps (3 vs. 1 becomes 3 vs. 2).

---

### Encounter: Bear Territory (Tier 2)

**Setup:**
- Single bear defending marked territory.
- Mountain path, narrow passage.
- Unavoidable charge attack on entry.

**Challenge:**
- Charge is unavoidable (must dodge or block).
- High damage output (20+ damage per hit).
- Slow but powerful (can't outrun).
- Winning requires armor + defensive skill.

**Lesson Taught:**
- Armor is mandatory (survival mechanic).
- Defense button timing matters (dodge/block).
- Preparation saves lives (come armed and armored).
- Risk/reward (dangerous area = rare loot).

---

### Encounter: Boss Arena - Ancient Dragon (Tier 4)

**Setup:**
- Circular arena, pillars for cover.
- Dragon in center, 3 phases.
- Environmental hazards (fire, falling rocks).

**Phase 1 (100-66% HP):**
- Single basic attacks, learnable pattern.
- Fire breath (telegraphed, avoidable with positioning).
- Summons minions (fire spirits).

**Phase 2 (66-33% HP):**
- Faster attacks, less predictable.
- Fire breath + ground effects (harder to escape).
- Minion summons increased.

**Phase 3 (33-0% HP):**
- Desperation: Multiple attacks, rapid fire.
- Arena hazards trigger (rocks falling, fire spreads).
- Minions don't spawn (simplified, different threat).

**Challenge:**
- All-day preparation event.
- 10-15 minute fight (not quick).
- Multiple team mechanics.
- Victory = permanent achievement.

**Lesson Taught:**
- Cooperation required (no solo).
- Preparation is everything (gear, food, strategy).
- Patience and pattern learning (not reflexes).
- Mastery = ultimate achievement.

---

## 8. CREATURE STAT PROGRESSION

### Stat Growth by Tier

| Stat | Tier 1 | Tier 2 | Tier 3 | Boss |
|------|--------|--------|--------|------|
| HP | 20-40 | 60-100 | 100-150 | 200-400 |
| DMG | 0-15 | 10-25 | 20-35 | 30-50 |
| DEF | 0-3 | 3-8 | 8-15 | 12-20 |
| Speed | 4-9 | 4-8 | 6-9 | 6-9 |
| Intelligence | 2-4 | 4-6 | 7-9 | 10 |

**Intelligence Scale:**
- 2-4: Scripted behavior, predictable patterns.
- 5-6: Reactive behavior, some adaptation.
- 7-9: Adaptive behavior, learns player tactics.
- 10: Perfect AI, optimal decisions.

---

## 9. COMBAT DIFFICULTY CURVES

### Win Rate Expectations

| Creature | Gear | Player Skill | Win Rate |
|----------|------|--------------|----------|
| Herbivore | Any | Any | 99% |
| Tier 1 Pack | Tier 1 | Beginner | 70% |
| Tier 1 Pack | Tier 2 | Beginner | 95% |
| Tier 2 Apex | Tier 2 | Intermediate | 50% |
| Tier 2 Apex | Tier 3 | Intermediate | 75% |
| Tier 3 Apex | Tier 3 | Advanced | 60% |
| Boss | Tier 3 | Mastery | 20% (first try) |

**Interpretation:**
- Gear progression makes fights easier (gear gatekeeping).
- Skill improvement visible (higher win rate over time).
- Mastery required for endgame (not just gear).
- Boss is skill check (even perfect gear doesn't guarantee win).

---

## V1 COMBAT SPECIFICATIONS

**Total Creatures:** 15-20.
**Attack Patterns:** 25+.
**Encounter Types:** 10+.
**Unique Boss Mechanics:** 3-5.

**Average Combat Duration:**
- Tier 1: 30 seconds.
- Tier 2: 2-3 minutes.
- Tier 3: 5-8 minutes.
- Boss: 10-15 minutes.

**Skill Progression Feel:**
- Early game: Button-mashing works.
- Mid game: Strategy matters, gear matters.
- Late game: Pattern learning required.
- Boss: Mastery + preparation = victory.

---

**Document Owner:** Technical Director  
**Last Updated:** July 10, 2026  
**Source:** Durango: Wild Lands desire-based AI research
