extends Control

func _ready():
	$AnimationPlayer.play("anim")
	if GameMaster.hunger >= GameMaster.hunger_cap:
		$RichTextLabel2.text = "[center][color=red]G'RAHA OVERFED"

func play_audio():
	SoundManager.play("sfx", "elden_ring_die")

func finish():
	queue_free()

func restart():
	GameMaster.show_restart()
