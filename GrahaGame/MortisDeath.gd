extends Control

func _ready():
	$AnimationPlayer.play("anim")
	if GameMaster.hunger >= GameMaster.hunger_cap:
		$RichTextLabel.text = "[center]G'RAHA OVERFED"

func _finish():
	queue_free()

func restart():
	GameMaster.show_restart()
