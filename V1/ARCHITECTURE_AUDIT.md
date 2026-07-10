# Architecture Future-Proof Audit

**Scope:** whole codebase, read-only. Goal: confirm *systems create rules, data creates content* holds before asset production.
**Method:** grep for the anti-patterns each check names (hardcoded content IDs, `if type == "..."`, per-content branches) + full read of core/systems/entities.
**Headline:** The core promise holds. **No gameplay system contains a single content-ID branch.** One system scores below 8 — **World (7/10)** — and its weakness is exactly the thing you're about to do next: swapping placeholder capsules for real models. Fix that seam first; everything else is add-content-as-data today.

---

## Scorecard

| System | Score | One-line |
|---|---|---|
| Item & Material | **9/10** | Generic property bag + base/modifier + unique instances + load-time validation. Add a material = a `.tres`. |
| Combat | **8/10** | No weapon-type branching; stats fully data-driven. Melee family is pure data; ranged/trap needs a seam that doesn't exist yet. |
| Creature | **9/10** | Pure data (`GameEntity type=creature`), behavior by reference, shared loot. No species branching anywhere. |
| Crafting | **9/10** | Category-tag slots + formula evaluation. Result from material props × quality × skill. Textbook Durango. |
| World & Resource | **7/10** | Gathering abstraction is excellent; **visuals are built in code inside gameplay nodes** and world layout is code-authored. Fix before assets. |

Below 8 → **World**. Recommendation: one refactor (visual separation) before asset production. Details in §3.

---

## 1. PASSED systems (evidence)

**Item & Material — CHECK 1 ✅**
`grep` for `bone_/wood_/stone_/spear/...` across `core/ systems/ entities/` returns only doc-comment examples — **no material-specific `if`, no hardcoded IDs in logic**. `MaterialDef` = `base_properties` + `modifiers` → `resolved_properties()`; `ItemInstance` carries rolled per-instance stats with a unique `instance_id`. Ancient Wood / Iron Ore / Rare Dinosaur Bone = new `.tres`, done. `Database.validate()` catches typo'd references at load. Property system is fully generic.

**Combat — CHECK 2 ✅ (with a named seam)**
`combat_system.gd` contains **no `if spear/bow/axe`**. `resolve_weapon()` pulls `damage`/`durability`/`attack_speed` from the crafted `ItemInstance` and `range` from the `ItemDef` — all data. A knife, axe, or hammer is a new ItemDef + recipe with different stats/formulas, **zero code**. Weapon data drives damage/range/speed/durability. (Seam gap in §2.)

**Creature — CHECK 3 ✅**
A creature is a plain `GameEntity` with `type="creature"` — there is **no `CreatureDef` class and no `if creature == "raptor"`** anywhere. `CreatureInstance.spawn()` reads `stats`, `behavior`, `drop_table` from data; composes a reused `CombatEntity`. Raptor / T-Rex / Triceratops = new `.tres`. Loot tables are auto-validated because they reuse the resource `drop_table` key.

**Behavior — CHECK 4 ✅**
Single dispatch point: `CreatureBehavior.for_name()` (`match behavior`). Adding Territorial / Pack-hunter / Nocturnal = **new subclass + one line in `for_name`**; no creature or existing module is edited. `creature_node.gd` reacts to the module's `Intent` enum, not to any creature type.

**Resource nodes — CHECK 5 ✅**
One `ResourceNode` + one `GatheringSystem` + one `LootSystem`. **No TreeSystem / MiningSystem / PlantSystem.** Acacia vs Iron vs Medicine differ only by `drop_table` data. Gathering and hunting share the same `LootSystem.roll()`.

**Crafting — CHECK 6 ✅**
`recipe_spear` requires `sharp_material` + `handle_material` (categories via tags), never concrete ingredients. `CraftingSystem` evaluates `stat_formulas` against supplied material properties + `skill_bonus`. Result = properties × quality × skill, **no fixed item stats**. Same recipe, different materials, different weapon — verified in the slice (dmg 35→82).

---

## 2. Architecture risks (ranked)

**R1 — Visuals are built in code inside gameplay nodes. [World, HIGH — blocks clean asset work]**
`player._build_body()`, `creature_node._build_placeholder()`, and `island._spawn_resource()` construct the mesh *inside the gameplay script*. Swapping a capsule for a dinosaur model today means **editing the gameplay node**, which violates CHECK 7 ("replacing the model must not affect gameplay"). This is the one risk that bites the very next phase.

**R2 — World layout is authored in code, not data. [World, MEDIUM]**
`island.gd` places every tree/rock/spawner via procedural calls. Fine for one test island; **"multiple islands" would mean copy-pasting code**, not authoring data/scenes. Not a rewrite of core systems (the systems are untouched), but the *world-authoring* approach won't scale to many islands.

**R3 — No weapon-behavior module seam for non-melee weapons. [Combat, MEDIUM — future]**
Knife/axe/hammer differ from the spear only in stats → pure data ✅. But **bow (projectile/ammo) and trap (placed, triggered) have a different interaction model** that `CombatSystem.attack(attacker, target, distance)` doesn't express. There is no weapon-behavior hook analogous to `CreatureBehavior`. Today this is YAGNI (no ranged weapon exists); it becomes a real refactor the day a bow is added.

**R4 — A few global combat constants aren't weapon-overridable. [Combat, LOW]**
`stamina_cost = 5 + weight*0.5`, `DURABILITY_LOSS_PER_HIT = 1.0`, `cooldown = 10/attack_speed` live in `CombatSystem`. A weapon can't declare its own wear rate or stamina profile. Each is already marked with a `ponytail:` upgrade note. Move to weapon data when a weapon needs to differ.

**R5 — Recipes have no requirements/quantity support. [Crafting, LOW]**
`skill_id` exists but no recipe is gated by skill level (`SkillDef.unlock_table` is emitted but unconsumed), and multi-count slots were removed as dead data. Both are *features not yet needed*, not architecture faults — the recipe schema can absorb them without a rewrite.

**R6 — HUD hardcodes the word "spear". [Presentation, TRIVIAL]**
`player.gd:182` prints `"spear dmg %.0f"` regardless of weapon. Cosmetic; use `def.display_name`.

**Non-risks (checked, fine):** creature/material/item authoring via the `properties` bag (consistent with resource nodes; validated at load); `all_of_type` is O(1) indexed; crafting formula typos caught by `Database.validate()`.

---

## 3. Required refactors before adding content

Only **one** is worth doing before you continue — and it's precisely because your next phase is assets:

**FIX NOW (before asset production) — Visual separation (addresses R1):**
Add a data-driven visual seam so a model swap is a `.tres` edit, not a code edit. Minimal shape:
- A `visual_scene` (PackedScene path) or `visual` key in entity `properties`.
- A tiny `VisualComponent` (or 3 lines in each entity's `_ready`) that instances that scene as a child, falling back to the current placeholder mesh when absent.
- `creature_node`, `player`, and `ResourceNode` read it; `_build_placeholder`/`_build_body` become the fallback only.
Result: capsule → dinosaur = point the data at a scene. Gameplay untouched. **~1 small component + 3 call sites.**

**DEFER (add when the trigger arrives):**
- R2 world-as-data → before the **second** island.
- R3 weapon-behavior module → before the **first bow/trap**.
- R4 weapon-owned combat constants → when a weapon needs a distinct profile.
- R5 recipe requirements/quantity → with the progression/crafting UI.
- R6 HUD label → whenever; one-line.

---

## 4. Save readiness (CHECK 8)

**Adequate, unimplemented.** `SaveManager` is a documented stub. The architecture is save-friendly:
- `ItemInstance extends Resource` and stores its **full rolled `properties`**, not just an id → generated items with custom stats serialize directly. **No "id-only" storage where runtime data matters.** ✅
- Skills, world node state (`uses_remaining`), and camp are plain data (dicts/floats), trivially serializable against the documented schema.
- `CreatureInstance`/`CombatEntity` are `RefCounted` holding plain floats/dicts — a wounded creature's world-state saves as data, reconstructable on load. No blocker.
No architecture change needed for save; it only needs implementing against the schema already written in `save_manager.gd`.

---

## Verdict

Four of five systems are 8–9/10 and **ready to receive content as pure data**: materials, weapons (melee), creatures, behaviors, resources, recipes — all add-by-`.tres`. The single actionable gap before your stated next step (assets) is **R1: give entities a data-driven visual seam** so model swaps never touch gameplay code. Do that one refactor; defer the rest until their trigger arrives.
