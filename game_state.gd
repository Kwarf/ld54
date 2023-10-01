extends Node

var total_hits_taken: int = 0
var total_deaths: int = 0
var start_time: float = Time.get_unix_time_from_system()

var current_level: String = "res://levels/level_1.tscn"
var current_health: int = 3:
	get:
		return current_health
	set(value):
		if value < current_health:
			self.total_hits_taken += 1
		if value == 0:
			print("You died!")
			self.total_deaths += 1
		current_health = value
		EventBus.health_changed.emit(value)


func switch_level(path: String) -> void:
	Transition.run()
	await Transition.faded_black
	get_tree().change_scene_to_file(path)
	current_level = path


func reload_level() -> void:
	switch_level(current_level)
	await Transition.done
	self.current_health = 3


func get_elapsed_time() -> String:
	var elapsed_seconds = Time.get_unix_time_from_system() - self.start_time
	var seconds: float = fmod(elapsed_seconds, 60.0)
	var minutes: int = int(elapsed_seconds / 60.0)
	return "%02d:%05.2f" % [minutes, seconds]
