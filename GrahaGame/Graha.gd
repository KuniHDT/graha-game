extends Area2D

func _process(delta):
	if GameMaster.ded == true:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
	

func _on_area_entered(area):
	if area.get_node("Draggable"):
		%StateChart.send_event("bite")
		if area.get_node("VerySmall"):
			GameMaster.score = GameMaster.score + 5
			GameMaster.hunger = GameMaster.hunger + 5
		if area.get_node("Small"):
			GameMaster.score = GameMaster.score + 15
			GameMaster.hunger = GameMaster.hunger + 15
		if area.get_node("Big"):
			GameMaster.score = GameMaster.score + 30
			GameMaster.hunger = GameMaster.hunger + 30
		if area.get_node("VeryBig"):
			GameMaster.score = GameMaster.score + 50
			GameMaster.hunger = GameMaster.hunger + 50
		if area.get_node("Stomach"):
			SoundManager.play("sfx", "power_up")
			GameMaster.hunger_cap = GameMaster.hunger_cap + 10
			GameMaster.score = GameMaster.score + 50
		if area.get_node("Pill"):
			GameMaster.score = GameMaster.score + 50
			SoundManager.play("sfx", "power_up")
			if GameMaster.protection != true:
				GameMaster.protection = true
		area.queue_free()

func bite_end():
	%StateChart.send_event("reset")

func _on_bite_state_entered():
	var randomizer = randi_range(0, 100)
	if randomizer >= 95 and randomizer <= 100:
		SoundManager.play("sfx", "taco_bell")
	
	SoundManager.play("sfx", "eat")

func _on_death_state_entered():
	SoundManager.play("sfx", "death_sound")
