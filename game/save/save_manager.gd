extends Node

## Autoload singleton. INTERFACE STUB for this pass — implementation lands in a
## later phase. The seam exists now so gameplay systems don't have to be
## rewritten when save/load arrives.
##
## Documented V1 save schema (see DATA_SCHEMA "Save Data Requirement"):
##   {
##     "player":    { stats... },
##     "inventory": [ ItemInstance, ... ],   # unique instances, not ids
##     "skills":    { skill_id: { level, xp } },
##     "world":     { resource_node_id: uses_remaining, ... },
##     "camp":      { structures... },
##   }
## ItemInstance already extends Resource, so instances serialize directly.

const SAVE_PATH := "user://savegame.tres"


func save_game(_slot: String = "default") -> bool:
	push_warning("[SaveManager] save_game not implemented yet (Phase 11)")
	return false


func load_game(_slot: String = "default") -> bool:
	push_warning("[SaveManager] load_game not implemented yet (Phase 11)")
	return false


func has_save(_slot: String = "default") -> bool:
	return FileAccess.file_exists(SAVE_PATH)
