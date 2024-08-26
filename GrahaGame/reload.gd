extends GameMaster

func _ready():
	reset()
	var timer = get_tree().create_timer(0.5)
	await timer.timeout
	get_tree().change_scene_to_file("res://game.tscn")
