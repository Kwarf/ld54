extends StaticBody3D


func _ready() -> void:
	$"Control/Stats".text = (
		"[center]You died %s times, taking %s hits, in %s[/center]"
		% [GameState.total_deaths, GameState.total_hits_taken, GameState.get_elapsed_time()]
	)
