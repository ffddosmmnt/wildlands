# VISUAL & UI REFERENCE
## 2.5D Mobile Art Direction (Durango: Wild Lands Model)

**Last Updated:** July 10, 2026  
**Version:** 2.0 (Durango-Accurate)  
**Platform:** Mobile (iOS/Android optimized)

---

## 1. ART DIRECTION OVERVIEW

### Visual Identity

**Durango: Wild Lands is a 2.5D isometric survival MMO with:**
- **Perspective:** Fixed isometric view (65° angle, no camera rotation).
- **Art Style:** Stylized 3D characters + pre-rendered environments.
- **Visual Hierarchy:** Clarity over aesthetics (gameplay legibility prioritized).
- **Target:** Mobile optimization (mid-range phones, tablets).

### Rendering Strategy (Hybrid)

**3D Rendered:**
- Player character (high-poly, expressive).
- NPCs and creatures (animated, dynamic).
- Interactive objects (doors, chests, crafting stations).
- UI elements (buttons, panels, inventory icons).

**Pre-Rendered/Sprite:**
- Background environments (distant terrain).
- Vegetation (trees, bushes, grass, flowers).
- Static structures (rocks, cliffs, ruins).
- Particle effects (fire, magic, weather).

**Performance:**
- Target: 60 FPS on mid-range phones (2020-era).
- LOD system: High-poly near, low-poly far.
- Draw calls optimized (batching, culling).
- Memory budget: 2-4 GB (mobile standard).

---

## 2. COLOR PALETTES BY BIOME

### Coastal Valley (Starter Biome)

**Primary Colors:**
- Grass green: `#5FAD56`
- Sky blue: `#87CEEB`
- Sand beige: `#E8D4A2`
- Water cyan: `#4DB8E8`

**Accent Colors:**
- Sunlight gold: `#FFD700`
- Sea foam: `#F0FFF0`
- Rock gray: `#8B8680`

**Mood:** Welcoming, safe, Mediterranean.

**UI Application:**
- Button backgrounds: Grass green.
- Danger warnings: Warm orange (standout).
- Safe zones: Light blue (water safe).

---

### Grassland Plains

**Primary Colors:**
- Golden grass: `#D4AF37`
- Sky blue (lighter): `#B0E0E6`
- Earth brown: `#8B4513`
- Stone gray: `#A9A9A9`

**Accent Colors:**
- Wheat yellow: `#F5DEB3`
- Shadow dark: `#36454F`
- Wildflower purple: `#9932CC`

**Mood:** Open, peaceful, agrarian.

---

### Mountain Foothills

**Primary Colors:**
- Rock gray: `#808080`
- Snow white: `#FFFAFA`
- Ore red: `#DC143C` (copper deposit glow).
- Ore orange: `#FF8C00` (visual cue).

**Accent Colors:**
- Peak shadow: `#4B0082` (indigo).
- Crystal blue: `#00FFFF` (magical materials).
- Lava red: `#FF4500` (danger zones).

**Mood:** Majestic, harsh, mineral-rich.

---

### Dense Forest

**Primary Colors:**
- Dark forest: `#228B22`
- Shadow green: `#1B4D1B`
- Tree bark: `#654321`
- Canopy shade: `#2F4F2F`

**Accent Colors:**
- Rare herb glow: `#7FFF00` (electric lime).
- Magical aura: `#9932CC` (rare spawns).
- Danger red: `#DC143C` (predators).

**Mood:** Mysterious, dangerous, ancient.

---

### Volcanic Peak (Unstable Island)

**Primary Colors:**
- Lava red: `#FF4500`
- Rock black: `#1C1C1C`
- Ash gray: `#808080`
- Sky orange: `#FFA500` (heat haze).

**Accent Colors:**
- Fire yellow: `#FFFF00` (active zones).
- Ember orange: `#FF6347` (danger).
- Smoke gray: `#D3D3D3` (atmosphere).

**Mood:** Hostile, dangerous, extreme.

---

## 3. TYPOGRAPHY & READABILITY

### Font Hierarchy

**Headlines (Biome Names, Quest Titles):**
- Font: Geist Bold or equivalent (sans-serif, strong).
- Size: 32-48px.
- Color: White with dark outline (3px shadow).
- Spacing: Generous (3-4 line-height).

**Body Text (Descriptions, Dialogue):**
- Font: Geist Regular or equivalent (sans-serif, readable).
- Size: 14-18px.
- Color: White on dark backgrounds, dark on light.
- Line height: 1.6x (mobile readability).

**Small Text (Stats, Tooltips):**
- Font: Geist Regular (smaller weight).
- Size: 11-13px.
- Color: Light gray or white.
- High contrast (readable at small size).

**Pixel/Retro (Game Stats, Health Counter):**
- Font: Press Start 2P or equivalent (8-bit style).
- Size: 12-16px.
- Color: Biome-appropriate (green=health, blue=mana, red=danger).
- Effect: Adds game feel, nostalgic.

### Color Usage

| Type | Color | Hex | Usage |
|------|-------|-----|-------|
| Default | Dark gray | `#2C2C2C` | Body text |
| Success | Bright green | `#4CAF50` | Quest complete, skill gain |
| Warning | Orange | `#FF9800` | Low resources, caution |
| Danger | Red | `#F44336` | Low health, critical |
| Rare | Purple | `#9C27B0` | Rare items, special drops |
| Legendary | Gold | `#FFD700` | Unique/apex items |
| Neutral | Gray | `#757575` | Disabled, closed |

---

## 4. UI COMPONENT LIBRARY

### Button Style

**Standard Button:**
- Size: 40-60px tall, 120-200px wide.
- Background: Biome-primary color (varies by island).
- Border: 2-3px darker shade.
- Text: White, centered, bold.
- Padding: 8px horizontal, 6px vertical.

**States:**

| State | Effect | Animation |
|-------|--------|-----------|
| Idle | Normal | None |
| Hover | Lighten +20% | Instant |
| Pressed | Darken -20%, scale 0.95 | 100ms |
| Disabled | Grayscale, opacity 50% | None |

**Sound:** Click sound on press (satisfying audio).

---

### Panel/Window

**Inventory Panel:**
- Background: Dark semi-transparent (rgba 0,0,0,0.85)).
- Border: 4px thick, gold accent color.
- Padding: 16px.
- Corner radius: 8px.
- Shadow: Drop shadow 4px offset, 50% opacity.
- Scrollable: If content exceeds screen (smooth scrolling).

**Content Layout:**
- Header bar (title, close button).
- Main content area (grid for items, text for descriptions).
- Footer (stats, buttons).

---

### HUD Elements (In-Game Overlay)

**Health Bar (Bottom-Left):**
- Background: Dark gray.
- Fill: Red (health depletes left-to-right).
- Border: 2px, darker.
- Label: "❤️ 100/100" (pixel font).
- Size: 150px wide, 24px tall.

**Stamina Bar (Bottom-Left, Below Health):**
- Background: Dark blue.
- Fill: Light blue (stamina depletes left-to-right).
- Label: "⚡ 100/100" (pixel font).

**Minimap (Top-Right Corner):**
- Size: 120×120 px (circular, adjustable).
- Background: Dark gray with border.
- Player marker: White dot (center).
- Creature markers: Red triangles (threats).
- POI markers: Yellow stars (interest points).
- Fog of war: Gray (unexplored areas).

**Biome Name (Top-Center):**
- Text: "Coastal Valley" (large, bold).
- Color: Gold/white with shadow.
- Duration: 5 seconds on biome entry, then fades.

**Interaction Prompt (Center-Bottom):**
- Text: "[E] Gather Wood" or "[E] Talk to NPC".
- Color: White with dark outline.
- Shows when player near interactive object.
- Disappears when out of range.

---

### Inventory Grid

**Layout:**
- 4 columns × 6 rows (24 base slots).
- Each slot: 64×64px (scales responsively).
- Slot border: 1px, semi-transparent.
- Hover effect: Slight glow, tooltip appears.

**Item Visual:**
- Icon: 56×56px (centered in slot).
- Count badge: Bottom-right corner ("+5" for stacks).
- Quality glow: Colored border (common=white, rare=purple, legendary=gold).
- Drag-and-drop: Smooth animation.

---

## 5. CREATURE & CHARACTER VISUAL DESIGN

### Player Character (Customizable)

**Base Model:**
- Height: ~6 units (standard scale).
- Proportions: Realistic-stylized (not chibi, not photorealistic).
- Customization: Gender, skin tone, hair, body type.

**Idle Animation:**
- Subtle breathing (chest rises, 2-sec cycle).
- Weight shift (sway, 4-sec cycle).
- Blink (eyes, 5-sec interval).
- Hand resting pose (varies by equipped weapon).

**Movement Animation:**
- Walk: Natural stride, ~1 m/s.
- Run: Faster stride, breathing visible, ~3 m/s.
- Dodge roll: 1-sec duration, invulnerable flash.
- Attack: Weapon-dependent (axe swing vs. bow draw).

---

### Creature Design Principles

**Silhouette Clarity:**
- Shape identifiable from 30+ meters away.
- No busy details that obscure outline.
- Size indicates threat level (bigger = stronger).

**Color & Biome Cohesion:**
- Coastal creatures: Blues, silvers, sandy tones.
- Forest creatures: Greens, browns, dark colors.
- Mountain creatures: Grays, whites, icy blues.
- Volcanic creatures: Reds, blacks, glowing accents.

**Personality Through Design:**
- Herbivore: Soft shapes, gentle eyes, rounded ears.
- Pack Hunter: Sharp angles, predatory eyes, alert posture.
- Territorial: Muscular build, prominent features, armor-like hide.
- Apex: Elegant but dangerous, complex patterns, intelligent expression.

### Example: Saber-Tooth Tiger (Tier 2 Apex)

**Visual Design:**
- Large feline frame (3-4m tall).
- Orange coat with dark stripes.
- Prominent saber fangs (proto-tusk shape).
- Scarred hide (battle history, character).
- Intelligent eyes (shows tactical awareness).
- Muscular, coiled posture (ready to pounce).

**Color Palette:**
- Primary: Orange (`#FF8C00`).
- Secondary: Dark brown (`#654321`).
- Scars: White (`#FFFACD`).
- Eyes: Golden (`#FFD700`).

**Animation Tells (Telegraphing):**
- Before pounce: Deep crouch, tail swish (player has 0.5 sec to react).
- Before bite: Mouth opens, fangs visible (0.3 sec warning).
- Victory: Slow strut around defeated prey (cinematic moment).

---

## 6. ANIMATION PRINCIPLES

### Attack Animations

**Light Attack (0.6 sec):**
- Anticipation (0.1 sec): Weapon raises.
- Attack (0.3 sec): Swing or thrust.
- Recovery (0.2 sec): Return to idle.
- Total: 0.6 sec (fast, repeatable).

**Heavy Attack (1.2 sec):**
- Anticipation (0.3 sec): Wind-up, visible strain.
- Attack (0.6 sec): Powerful swing.
- Recovery (0.3 sec): Long recovery (slow follow-up).
- Total: 1.2 sec (powerful, low-speed).

**Ranged Attack (0.8 sec):**
- Draw (0.3 sec): Pull back bow or crossbow.
- Aim (0.2 sec): Sight alignment.
- Release (0.3 sec): Arrow fires.
- Total: 0.8 sec (consistent, telegraphed).

### Status Effects (Visual Feedback)

**Damage Taken:**
- Screen flash: White flash (0.1 sec).
- Screen shake: Minor (0.2 sec).
- Damage number: Pops up, fades (1 sec, color = damage type).

**Buff Active:**
- Character glow: Golden shimmer around character.
- Buff icon: Top-left, shows buff type (sword=attack, shield=defense).
- Duration bar: Visible countdown (expires after time).

**Debuff Active (Poison):**
- Character aura: Green particle mist.
- Debuff icon: Top-left, shows debuff type.
- Health drain: Visual effect (blood mist).

**Status Effect Examples:**

| Effect | Color | Animation |
|--------|-------|-----------|
| Poison | Green | Mist swirls |
| Fire | Orange-red | Flame aura |
| Ice | Cyan | Frost sparkles |
| Healing | Gold | Shimmer upward |
| Speed Boost | Blue | Motion blur |

---

## 7. HUD LAYOUT & SCREEN COMPOSITION

### Standard In-Game HUD

```
┌─────────────────────────────────────────────────┐
│ MINIMAP (120×120, top-right)   BIOME: Grassland │
│ 🗺️ Circular, creatures visible  (top-center)   │
│                                                 │
│            GAME WORLD (ISOMETRIC)              │
│                                                 │
│            [Player Character Here]             │
│      [Creatures, Trees, Objects Visible]       │
│                                                 │
│ ❤️ 100/100                   [E] Gather Wood   │
│ ⚡ 100/100                   (interaction hint)│
│ (bottom-left stats)      (center-bottom hint) │
│                                                 │
│ [Sword] [Shield] [Bow] [Apple] [Empty]        │
│ (quick-access hotbar, bottom-right)           │
└─────────────────────────────────────────────────┘
```

### Inventory Screen (Full-Screen Modal)

```
┌───────────────────────────────────────────────────┐
│ INVENTORY  (X to close)                            │
├───────────────────────────────────────────────────┤
│ Equipment (Left)       │ Items Grid (Right)       │
│ ┌──────────────────┐  │ ┌────────────────────┐  │
│ │ Head: [Helmet]   │  │ │[Ore][Ore][Stone]   │  │
│ │ Chest: [Armor]   │  │ │[Hide][Hide][Meat]  │  │
│ │ Legs: [Pants]    │  │ │[Wood][Wood][Apple] │  │
│ │ Hands: [Gloves]  │  │ │[Empty][Empty]...   │  │
│ │ Primary: [Sword] │  │ ⚖️ 18/30 kg (60%)     │  │
│ │ Secondary:[Shield] │ │                     │  │
│ └──────────────────┘  │ └────────────────────┘  │
│ Item Description (Bottom)                        │
│ Copper Ore - Used for smelting. Weight: 2kg    │
└───────────────────────────────────────────────────┘
```

---

## 8. MOBILE OPTIMIZATION (CRITICAL)

### Screen Size Adaptation

**Phone (1920×1080, 16:9):**
- Minimap: 100×100 px (fits corner).
- UI: Scaled to 1x.
- Touch targets: 40-60px (fingers, not mice).

**Tablet (2560×1440, 16:9):**
- Minimap: 150×150 px (larger screen).
- UI: Scaled to 1.2-1.5x.
- Touch targets: 60-80px.

**Ultra-wide (not typical, use letterboxing):**
- Maintain 16:9 aspect ratio.
- Black bars on sides (prevents stretching).

### Touch Input

**Tap Interactions:**
- Attack: Tap enemy (hold for heavy attack).
- Move: Tap ground (pathfinding auto-walk).
- Interact: Tap object (gathering, talking).
- Menu: Tap UI buttons (40px+ for comfortable touch).

**Swipe Gestures:**
- Inventory scroll: Swipe up/down (smooth).
- Map pan (if allowed): Swipe to move view.
- Dodge roll: Swipe direction + hold (or virtual joystick).

---

## 9. VISUAL ACCESSIBILITY

### Color Blindness Safe Design

**Avoid:** Red-green as only distinction.  
**Instead:** Use shape + color + text labels.

**Example - Damaged vs. Healthy:**
- Healthy: Green bar, full, heart icon.
- Damaged: Red bar, partial, damage icon.
- Both: Clear icons and text "Low Health" (colorblind-safe).

### Text Contrast

**Minimum Ratios:**
- Large text (18+px): 3:1 contrast.
- Normal text: 4.5:1 contrast.
- Examples:
  - White text on dark: ✓ (high contrast).
  - Light gray on white: ✗ (low contrast, fail).

### Icon Readability

- Minimum 32×32px at normal zoom.
- Bold outlines (stand out from background).
- Tooltips on hover (text fallback).
- Consistent meanings (health bar always green, ever).

---

## 10. VISUAL POLISH CHECKLIST

**Character Quality:**
- [ ] Player character has idle, walk, run, attack animations.
- [ ] Creatures have 3+ unique animations each.
- [ ] Attack wind-ups are telegraphed (0.3+ sec visible).
- [ ] Death animations feel impactful (not instant pop).

**Environment Quality:**
- [ ] All biomes have distinctive visual identity.
- [ ] LOD scaling works (no popping, smooth LOD).
- [ ] Collision visuals match actual collision (no clipping).
- [ ] Lighting is consistent (matches time of day).

**UI Quality:**
- [ ] No text overlaps or clipping.
- [ ] Button states clear (hover, pressed, disabled).
- [ ] HUD readable at small text size (14+px).
- [ ] Menu transitions smooth (no jarring).

**Effects Quality:**
- [ ] Damage numbers readable, color-coded.
- [ ] Particle effects don't obscure gameplay.
- [ ] Status effect visuals are obvious (not subtle).
- [ ] Loot drops are satisfying (visual + sound).

---

## V1 VISUAL SPECIFICATIONS

**Target Platform:** Mobile (iOS 14+, Android 10+).  
**Rendering:** Unity or Godot with 2.5D isometric pipeline.  
**Resolution:** 1920×1080 (16:9, scalable).  
**Frame Rate:** 60 FPS target (30 FPS minimum).  
**Color Depth:** 24-bit (16.7M colors).  
**Memory:** 2-4 GB (mid-range phone constraint).

**Asset Counts:**
- 3D Character Models: 1 player + 15-20 creatures.
- 2D Sprite Packs: 50+ (vegetation, props, effects).
- UI Components: 100+ (buttons, panels, icons).
- Animations: 250+ (character, creature, effect).
- Particle Effects: 30+ (fire, poison, magic, weather).

---

**Document Owner:** Technical Director  
**Last Updated:** July 10, 2026  
**Source:** Durango: Wild Lands mobile art direction research
