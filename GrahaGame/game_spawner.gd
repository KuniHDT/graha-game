extends Node2D

@onready var burger = preload("res://burger.tscn")
@onready var taco = preload("res://taco.tscn")
@onready var bun = preload("res://bun.tscn")
@onready var dango = preload("res://dango.tscn")
@onready var stomach = preload("res://stomach.tscn")
@onready var pill = preload("res://pill.tscn")
@onready var food_timer = $FoodTimer

func _on_food_timer_timeout():
	if GameMaster.ded == true or GameMaster.game_start == false:
		return
	spawn_food()

func spawn_food():
	var randomizer = randi_range(0, 100)
	var random_food = randi_range(1, 4)
	if randomizer >= 90 and randomizer <= 100:
		spawn_stomach()
	elif randomizer >= 85 and randomizer <= 89:
		spawn_pill()
	else:
		match random_food:
			1:
				spawn_burger()
			2:
				spawn_taco()
			3:
				spawn_bun()
			4:
				spawn_dango()

func spawn_burger():
	var new_food = burger.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)

func spawn_taco():
	var new_food = taco.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)

func spawn_bun():
	var new_food = bun.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)
	
func spawn_dango():
	var new_food = dango.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)
	
func spawn_stomach():
	var new_food = stomach.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)
	
func spawn_pill():
	var new_food = pill.instantiate()
	new_food.position = Vector2(randi_range(-270, 270), randi_range(-50, -260))
	add_child(new_food)
