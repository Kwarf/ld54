class_name Projectile
extends Area3D

@export var velocity: float = 8.0

@export_range(0, 31) var color_index: int:
	get:
		return $Projectile.get_surface_override_material(0).get_shader_parameter("color_index")
	set(value):
		$Projectile.get_surface_override_material(0).set_shader_parameter("color_index", value)


func _process(delta: float) -> void:
	translate(Vector3(0, 0, -velocity) * delta)
