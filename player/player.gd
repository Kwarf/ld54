extends CharacterBody3D

const SPEED = 5.0

@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var mesh: MeshInstance3D = $Player
@onready var bullet_timer: AnimationPlayer = $"Player/Bullet Spawner/Timer"

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _input(event: InputEvent) -> void:
	if not bullet_timer.is_playing() and event.is_action_pressed("shoot"):
		bullet_timer.play("shoot")
	elif event.is_action_released("shoot"):
		bullet_timer.stop()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Rotate the player to face the mouse.
	var offset = -PI * 0.5
	var screen_pos = camera.unproject_position(global_transform.origin)
	var mouse_pos = get_viewport().get_mouse_position()
	var angle = screen_pos.angle_to_point(mouse_pos)
	mesh.rotation.y = -angle + offset

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
