class_name Interactor
extends Node

## Reusable interaction component: finds the nearest node in the "interactable"
## group within range. Distance-based (no physics/Area3D) — the interactable set
## is tiny, so an O(n) scan per key-press is cheaper than collision wiring.
## ponytail: O(n) group scan; add an Area3D broadphase if the world ever holds
## hundreds of interactables in view at once.

func nearest(from: Vector3, max_range: float) -> Node3D:
	var best: Node3D = null
	var best_d := max_range
	for n in get_tree().get_nodes_in_group("interactable"):
		if n is Node3D:
			var d := from.distance_to((n as Node3D).global_position)
			if d <= best_d:
				best_d = d
				best = n
	return best
