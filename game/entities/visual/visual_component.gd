class_name VisualComponent
extends Node3D

## Data-driven visual layer. A gameplay node attaches one of these and hands it
## a `spec` (from resource data); the component builds the visual — a real asset
## scene when `spec.scene` is set, otherwise a placeholder primitive. Gameplay
## scripts never build meshes or know model details, so swapping a capsule for a
## real model is a DATA change (set `scene`), never a code change.
##
## spec (every key optional):
##   "scene": "res://models/raptor.tscn"   # real asset; used when present & valid
##   "shape": "capsule" | "box"            # placeholder shape (default: capsule)
##   "color": [r, g, b]                    # placeholder tint
##   "size":  [x, y, z]                    # placeholder size (x = diameter for capsule)

var spec: Dictionary = {}


static func attach(parent: Node3D, visual_spec: Dictionary) -> VisualComponent:
	var vc := VisualComponent.new()
	vc.spec = visual_spec
	parent.add_child(vc)
	return vc


func _ready() -> void:
	var scene_path := String(spec.get("scene", ""))
	if scene_path != "":
		var res := load(scene_path)
		if res is PackedScene:
			add_child((res as PackedScene).instantiate())
			return
		push_warning("[Visual] scene '%s' missing/invalid -> placeholder" % scene_path)
	add_child(_placeholder())


func _placeholder() -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	var y_off := 0.0
	if String(spec.get("shape", "capsule")) == "box":
		var s := _vec3(spec.get("size"), Vector3(0.9, 1.0, 0.9))
		var box := BoxMesh.new()
		box.size = s
		mi.mesh = box
		y_off = s.y * 0.5
	else:
		var s := _vec3(spec.get("size"), Vector3(0.8, 1.6, 0.8))
		var cap := CapsuleMesh.new()
		cap.radius = s.x * 0.5
		cap.height = s.y
		mi.mesh = cap
		y_off = s.y * 0.5
	var mat := StandardMaterial3D.new()
	mat.albedo_color = _color(spec.get("color"))
	mi.material_override = mat
	mi.position.y = y_off
	return mi


func _color(v: Variant) -> Color:
	if v is Color:
		return v
	if v is Array and v.size() >= 3:
		return Color(v[0], v[1], v[2])
	return Color(0.7, 0.7, 0.7)


func _vec3(v: Variant, fallback: Vector3) -> Vector3:
	if v is Vector3:
		return v
	if v is Array and v.size() >= 3:
		return Vector3(v[0], v[1], v[2])
	return fallback
