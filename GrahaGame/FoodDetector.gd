extends Area2D

func _process(delta):
	if GameMaster.ded == true:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false

func _on_area_entered(area):
	%StateChart.send_event("open_mouth")
