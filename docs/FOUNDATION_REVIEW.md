# Foundation Technical Review

**Scope:** Phases 0–5 (foundation vertical slice), read-only audit before combat/creature work.
**Verified:** `godot --headless --path game` → `RESULT: PASS` (6/6 checks, 12 entities / 1 recipe / 5 skills).
**Verdict:** Architecture is sound and honestly data-driven. No rewrites needed. A handful of scalability seams and hardcoded tuning constants should be closed *before* content multiplies — cheap now, painful later.

---

## 1. Approved systems

These match CLAUDE.md / GAME_DESIGN.md / DATA_SCHEMA.md and will survive expansion as-is.

| System | Why it's approved |
|---|---|
| **Database** (`core/database.gd`) | Recursive scan of `res://data`, indexed by id, dispatched by class (`RecipeDef`/`SkillDef`/`GameEntity`). Adding content is genuinely "drop a `.tres`". Zero content hardcoded in code. |
| **Entity model** (`GameEntity` → `MaterialDef`/`ItemDef`) | One level of inheritance; everything variable lives in `tags` + `properties`. Composition-first, exactly as the docs demand. Creatures slot in as `type="creature"` + a behavior-module tag with **no new inheritance**. |
| **Material model** (`MaterialDef`) | `base_properties` + `modifiers` → `resolved_properties()`. Matches the Durango "same base bone, different source" spec 1:1 (`bone_predator` proves it). |
| **Crafting** (`crafting_system.gd` + `RecipeDef`) | The crown jewel. Category-tag slots + `Expression` stat formulas = same recipe, different result, **no per-recipe code**. Fully data-driven. This is the correct foundation for 50 weapons. |
| **Item instances** (`ItemInstance`) | Unique per craft/gather, stack only when properties are identical. Satisfies "Bone #001 ≠ Bone #002". |
| **Learn-by-doing** (`EventBus` + `SkillSystem`) | Systems emit `action_performed`; SkillSystem listens. No system references skills directly. Textbook decoupling and correct progression philosophy. |
| **Player inventory** (`Inventory`) | O(n) queries, but player inventory is bounded-small — indexing it would be over-engineering. Approved as-is (see §3). |

---

## 2. Problems found

### P1 — No data validation at load (silent bad data) · **HIGH**
`Database` indexes any `.tres` it finds; nothing checks referential integrity. A recipe whose `output_type` doesn't exist, a `drop_table` naming an unknown material, or a slot with a typo'd `accepts_tag` fails **silently or only at craft/gather time**. With 1000 hand-authored items and 100 creature loot tables, malformed data is the single most likely real bug — and the hardest to trace.

### P2 — Formula typos silently resolve to 0 · **HIGH (pairs with P1)**
`_MaterialVars._get()` returns `0.0` for any missing property. A formula typo — `tip.sharpnesss` — doesn't error; it yields a silently wrong stat. Across 50 weapons × several formulas each, this is a balance bug that never throws. It hides inside the otherwise-excellent Expression system.

### P3 — `Database.all_of_type()` is an O(n) full scan · **MEDIUM**
```gdscript
func all_of_type(type): for e in _entities.values(): if e.type == type ...
```
Every creature spawn ("give me all creatures") and every crafting-UI open ("recipes for this skill") re-scans the entire entity table. Fine at 12 entities; at 1000 items + 100 creatures this is the exact "will it survive scale?" failure CLAUDE.md names. `all_recipes()` returns the raw values list (no filter), so a "recipes I can craft" query also scans everything.

### P4 — Hardcoded gameplay tuning in code, not data · **MEDIUM**
- `SkillSystem.get_bonus()` returns `level * 0.02` — a **flat curve identical for all 5 skills**, contradicting GAME_DESIGN (each skill improves *different* things). Combat will read the hunting bonus from this same flat number.
- `GatheringSystem`: `XP_PER_GATHER = 8.0`, quality roll `base_quality * (1+bonus) + tool*0.5 + randf(-5,5)` — tuning constants baked into code.

One gathering formula is acceptable to keep in code; the **per-skill bonus is not** — it's the knob you'll retune constantly once combat exists.

### P5 — `RecipeDef.slots[].count` is dead data · **MEDIUM**
Recipe slots declare `"count": 1`, but `CraftingSystem` ignores it — it consumes exactly one instance per `slot_id`. A "2× fiber" recipe would silently use one. A data field the engine lies about is a trap for content authors. Either implement `count` or delete the field.

### P6 — Field-placement convention is unstated · **LOW**
`ItemDef` promotes `category` and `material_slots` to `@export` fields while resource nodes keep `biome`/`drop_table` inside the `properties` bag. Both work, but there's no written rule for "when does data earn a typed field vs. live in `properties`?" Decide and document it before 1000 items, or authors will scatter the same concept across both.

---

## 3. Explicitly NOT problems (don't "fix" these)

- **`Inventory` O(n) queries** — player inventory is small and bounded; indexing it is speculative complexity. Leave it.
- **Expression re-parsed per craft** — crafting is user-paced, not a hot loop. Cache the parsed `Expression` only if a profiler ever complains. YAGNI.
- **Crafting doesn't consume inputs / gate by skill level** — genuinely absent, but these belong with the crafting **UI**, not the audit. Not a foundation defect.
- **`SaveManager` is a stub** — deliberate seam; schema is documented. Correct for this phase.

---

## 4. Priority fixes before combat

Ordered by ROI. All are small; combat/creatures build directly on 1–3.

1. **`Database.validate()` (P1 + P2)** — a debug-only pass run after `reload()`: assert every `recipe.output_type`, every `drop_table.material`, and every slot `accepts_tag` resolves; warn on any material property referenced by a formula that no accepted material provides. Catches authoring bugs the moment you start writing creatures + loot tables. *Highest value — do this first.*
2. **Type/tag index in `Database` (P3)** — build `type → [entities]` (and optionally `tag → [entities]`) once at load; make `all_of_type()` a dict lookup. The creature spawner and crafting UI you're about to write both need it; retrofitting after they exist is churn.
3. **Move per-skill bonus to `SkillDef` (P4)** — add `bonus_per_level` (or a small curve) to the skill resource so hunting/crafting/gathering scale differently. Do it before combat reads the hunting bonus, so you tune data, not code.
4. **Resolve `count` (P5)** — implement multi-count slot consumption, or delete the field. Cheap; prevents a silent-loss bug as recipes multiply.

**Defer past combat:** P6 convention doc (write it when you notice the second author confused), consume-on-craft + skill-gated recipes (land with the crafting UI), Expression caching (only if profiled).

---

## 5. Scale sanity check

| Question (CLAUDE.md) | Answer |
|---|---|
| Survive 1000 items? | **Yes**, after P1–P3. The data model is right; only lookup indexing + validation are missing. |
| Survive 100 creatures? | **Yes** — creatures are `GameEntity` + behavior-module tag, no new class per species. Spawner needs the P3 index. |
| Survive 50 weapons? | **Yes** — the tag-slot + formula recipe system is already weapon-agnostic; the spear hardcodes nothing. |
| Inheritance risk? | **Low** — one shallow level, composition everywhere. |

**Bottom line:** ship P1–P4 (all small), then build combat on top. The foundation is a keeper.
