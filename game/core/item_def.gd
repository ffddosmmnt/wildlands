@tool
class_name ItemDef
extends GameEntity

## A simple (non-material) item definition, e.g. fiber, crafted tools.
## Materials use MaterialDef; everything else that is still just "content"
## can use this. Crafted equipment is produced as an ItemInstance whose
## def_id points at an ItemDef like "spear".

## e.g. "resource", "tool", "weapon", "consumable".
@export var category: String = ""
## Material slots this item exposes when crafted (empty for raw items).
## Used by weapons: e.g. ["tip", "handle"] for a spear.
@export var material_slots: Array[String] = []
