extends Control

func _ready():
	$AnimationPlayer.play("anim")

func play_audio():
	SoundManager.play("sfx", "normal_death")

func finish():
	queue_free()

func restart():
	GameMaster.show_restart()
