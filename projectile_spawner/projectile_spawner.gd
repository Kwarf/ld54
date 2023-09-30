class_name ProjectileSpawner
extends Node3D

@export_range(0, 31) var color_index: int
@export var group: String

var scene: Resource = preload("res://projectile/projectile.tscn")


func spawn() -> void:
	var projectile: Projectile = scene.instantiate()
	get_tree().get_root().add_child(projectile)
	if group != "":
		projectile.add_to_group(group)
	projectile.set_as_top_level(true)
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	projectile.color_index = color_index
