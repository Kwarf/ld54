class_name Enemy
extends AnimatableBody3D

@export var bullet_interval = 1.0

var health = 3


func _enter_tree() -> void:
	# Add new timer as a child node
	var timer = Timer.new()
	timer.wait_time = bullet_interval
	timer.autostart = true
	timer.timeout.connect(shoot)
	add_child(timer)


func _ready() -> void:
	add_to_group("enemies")


func shoot() -> void:
	# Trigger all ProjectileSpawner nodes of this enemy
	for node in find_children("*", "ProjectileSpawner"):
		if node is ProjectileSpawner:
			node.spawn(2.0)


func take_damage() -> void:
	# Decrease health
	health -= 1

	# If health is 0 or less, destroy this enemy
	if health <= 0:
		EventBus.enemy_killed.emit(self)
		queue_free()
