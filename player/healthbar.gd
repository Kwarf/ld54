extends Node3D


func _ready() -> void:
	EventBus.health_changed.connect(_update)


func _update(health: int) -> void:
	$"1".available = health > 0
	$"2".available = health > 1
	$"3".available = health > 2
