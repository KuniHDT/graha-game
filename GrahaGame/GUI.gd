extends Control

@onready var score_text = $ScoreText
@onready var hunger_text = $HungerText
@onready var diff_text = $DifficultyText
@onready var tutorial = %Tutorial

func _ready():
	$ColorRect.self_modulate = Color(1, 1, 1, 1)
	var tween = create_tween()
	tween.tween_property($ColorRect, "self_modulate", Color(1, 1, 1, 0), 0.5)

func _process(delta):
	score_text.text = "Points: " + str(GameMaster.score) + "  High: " + str(GameMaster.high_score)
	hunger_text.text = str(int(GameMaster.hunger))
	diff_text.text = "Difficulty: x" + str(snappedf(GameMaster.difficulty_modifier, 0.01))
	
	$HungerBar.value = GameMaster.hunger
	$HungerBar.max_value = GameMaster.hunger_cap
	$HungerBar.custom_minimum_size.y = (GameMaster.hunger_cap / 4)
	
	if GameMaster.hunger_cap == 550:
		$MAX.show()
	else:
		$MAX.hide()
	
	if GameMaster.protection == true:
		$HungerBar.material.set_shader_parameter("width", 1)
	else:
		$HungerBar.material.set_shader_parameter("width", 0)

func _input(event):
	if GameMaster.game_start == false:
		if $Tutorial.visible == false:
			if event is InputEvent and event.is_action("left_click"):
				GameMaster.game_start = true
				print("GAMU STATO!")
				$StartText.hide()

	if event is InputEventKey and event.pressed and event.is_action("tutorial"):
		tutorial.visible = !tutorial.visible
		$HelpText.visible = !$HelpText.visible
		get_tree().paused = !get_tree().paused
	#if event is InputEventKey and event.pressed and event.is_action("restart"):
		#restart()

func _on_restart_button_pressed():
	restart()

func restart():
	$RestartButton.hide()
	var tween = create_tween()
	tween.tween_property($ColorRect, "self_modulate", Color(1, 1, 1, 1), 0.5)
	await tween.finished
	$StartText.show()
	GameMaster.reset()
	var tween2 = create_tween()
	tween2.tween_property($ColorRect, "self_modulate", Color(1, 1, 1, 0), 0.5)
