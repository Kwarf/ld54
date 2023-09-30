extends Control

signal faded_black
signal done


func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)


func _notify_faded_black() -> void:
	faded_black.emit()


func _on_animation_finished(_anim_name: String) -> void:
	done.emit()


func run() -> void:
	$AnimationPlayer.play("level_transition")
