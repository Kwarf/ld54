extends Node


func switch_level(path: String) -> void:
	Transition.run()
	await Transition.faded_black
	get_tree().change_scene_to_file(path)
