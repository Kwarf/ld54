extends Node3D

@export var available: bool = true:
	get:
		return $Player.get_surface_override_material(0).get_shader_param("color_index") == 17
	set(value):
		if value:
			$Player.get_surface_override_material(0).set_shader_parameter("color_index", 17)
		else:
			$Player.get_surface_override_material(0).set_shader_parameter("color_index", 21)
