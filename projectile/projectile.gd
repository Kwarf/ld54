class_name Projectile
extends Area3D

@export var velocity: float = 8.0

@export_range(0, 31) var color_index: int:
	get:
		return $Projectile.get_surface_override_material(0).get_shader_parameter("color_index")
	set(value):
		$Projectile.get_surface_override_material(0).set_shader_parameter("color_index", value)


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	translate(Vector3(0, 0, -velocity) * delta)


func _on_body_entered(body: Node) -> void:
	var is_player_projectile = is_in_group("player_projectile")
	if not is_player_projectile and body.is_in_group("enemies"):
		return  # enemy projectiles should not damage each other, and pass through eachother
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
