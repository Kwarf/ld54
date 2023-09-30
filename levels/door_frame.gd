extends StaticBody3D

@export_file("*.tscn") var next_room: String


func _ready() -> void:
	EventBus.enemy_killed.connect(_on_enemy_killed)
	$TransitionTrigger.body_entered.connect(_on_transition_trigger_body_entered)


func _on_enemy_killed(_enemy: Node) -> void:
	# If the last enemy was killed, open the door
	if get_tree().get_nodes_in_group("enemies").size() == 1:
		$AnimationPlayer.play("open")


func _on_transition_trigger_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		GameState.switch_level(next_room)
