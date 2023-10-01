@tool
extends StaticBody3D

@export_range(4, 16, 2) var width: int = 16:
	get:
		return width
	set(value):
		width = value
		if Engine.is_editor_hint():
			recreate()

@export_range(4, 13) var height: int = 13:
	get:
		return height
	set(value):
		height = value
		if Engine.is_editor_hint():
			recreate()

@export_file("*.tscn") var next_room: String:
	get:
		return $DoorFrame.next_room
	set(value):
		$DoorFrame.next_room = value

var walls: MultiMeshInstance3D


func _enter_tree() -> void:
	recreate()


func recreate() -> void:
	_recreate_meshes()
	_resize_floor()
	_reposition_colliders()
	_reposition_door()


func _recreate_meshes() -> void:
	if walls == null:
		walls = get_node("Walls")
	assert(walls != null)
	walls.multimesh.instance_count = width * 2 + height * 2 - 4

	var i = 0
	for w in range(width):
		if w != width / 2 and w + 1 != width / 2:
			walls.multimesh.set_instance_transform(
				i, Transform3D(Basis(), Vector3(-width / 2.0 + w, 0, -height / 2.0))
			)
			i += 1
		walls.multimesh.set_instance_transform(
			i, Transform3D(Basis(), Vector3(-width / 2.0 + w, 0, height / 2.0 - 1))
		)
		i += 1

	for h in range(height - 1):
		walls.multimesh.set_instance_transform(
			i, Transform3D(Basis(), Vector3(-width / 2.0, 0, -height / 2.0 + h + 1))
		)
		i += 1
		walls.multimesh.set_instance_transform(
			i, Transform3D(Basis(), Vector3(width / 2.0 - 1, 0, -height / 2.0 + h + 1))
		)
		i += 1


func _resize_floor() -> void:
	$Floor.mesh.size = Vector2(width, height)
	$Floor.get_surface_override_material(0).uv1_scale = Vector3(width / 16.0, height / 13.0, 1)


func _reposition_colliders() -> void:
	$TopLeft.shape.extents = Vector3(width / 4.0 - 0.5, 0.5, 0.5)
	$TopLeft.position = Vector3(-width / 4.0 - 0.5, 0.5, -height / 2.0 + 0.5)
	# No need to set shape extents, it's the same instance as TopLeft
	$TopRight.position = Vector3(width / 4.0 + 0.5, 0.5, -height / 2.0 + 0.5)
	$Left.shape.extents = Vector3(0.5, 0.5, height / 2.0 - 1)
	$Left.position = Vector3(-width / 2.0 + 0.5, 0.5, 0)
	# No need to set shape extents, it's the same instance as Left
	$Right.position = Vector3(width / 2.0 - 0.5, 0.5, 0)
	$Bottom.shape.extents = Vector3(width / 2.0, 0.5, 0.5)
	$Bottom.position = Vector3(0, 0.5, height / 2.0 - 0.5)


func _reposition_door() -> void:
	$DoorFrame.position.z = (13 - height) / 2.0
