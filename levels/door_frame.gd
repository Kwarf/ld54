extends StaticBody3D


func _ready() -> void:
	EventBus.enemy_killed.connect(_on_enemy_killed)


func _on_enemy_killed(_enemy: Node) -> void:
	# If the last enemy was killed, open the door
	if get_tree().get_nodes_in_group("enemies").size() == 1:
		$AnimationPlayer.play("open")
