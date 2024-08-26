extends Node2D

@onready var parent = get_parent()
@onready var timer = get_parent().get_node("ExpireTimer")

var wiggle_speed = 2.0
var wiggle_amplitude = 0.005
var wiggle_time:float

var original_scale

var draggable = false
var dragging = false

func _ready():
	GameMaster.deletus.connect(_on_deletus)
	original_scale = parent.scale
	timer.start()

func _process(delta):
	if draggable:
		if Input.is_action_pressed("left_click"):
			dragging = true
			var parent = get_parent()
			var tween = create_tween()
			tween.tween_property(parent, "global_position", get_global_mouse_position(), 0.1)
		elif Input.is_action_just_released("left_click"):
			dragging = false
			disappear()

	if timer.is_stopped():
		disappear()

func _physics_process(delta):
	#Wiggle object
	wiggle_time = wiggle_time + delta
	var mov = cos(wiggle_time * wiggle_speed) * wiggle_amplitude
	parent.global_rotation = parent.global_rotation + mov
	
func _on_cake_mouse_entered():
	draggable = true
	var tween = create_tween()
	tween.tween_property(parent, "scale", parent.scale + Vector2(0.2, 0.2), 0.1)

func _on_cake_mouse_exited():
	if dragging != true:
		draggable = false
	var tween = create_tween()
	tween.tween_property(parent, "scale", original_scale, 0.1)

func disappear():
	var tween = create_tween()
	tween.tween_property(parent, "scale", Vector2(0, 0), 0.1)
	await tween.finished
	parent.queue_free()

func _on_deletus():
	var tween = create_tween()
	tween.tween_property(parent, "scale", Vector2(0, 0), 0.1)
	await tween.finished
	parent.queue_free()
