extends Node

signal deletus

@onready var burger = preload("res://burger.tscn")
@onready var taco = preload("res://taco.tscn")
@onready var bune = preload("res://bun.tscn")
@onready var dango = preload("res://dango.tscn")
@onready var stomach = preload("res://stomach.tscn")
@onready var pill = preload("res://pill.tscn")

@onready var elden_ring_death = preload("res://elden_ring_death.tscn")
@onready var mortis_death = preload("res://mortis_death.tscn")
@onready var normal_death = preload("res://normal_death.tscn")

@onready var restart_button = get_tree().current_scene.get_node("CanvasLayer/GUI/RestartButton")
@onready var state_chart = get_tree().current_scene.get_node("Graha/StateChart")
@onready var music_player = get_tree().current_scene.get_node("AudioStreamPlayer")

@onready var food_timer = get_tree().current_scene.get_node("FoodTimer")

var difficulty_modifier
var score:float
var high_score:int
var hunger:float
var hunger_cap:float
var hunger_speed:float
var protection:bool
var ded:bool
var game_start:bool

func reset():
	deletus.emit()
	music_player.volume_db = -3
	difficulty_modifier = 1
	score = 0
	hunger = 60
	hunger_cap = 100
	protection = false
	ded = false
	game_start = false
	food_timer.wait_time = 3
	state_chart.send_event("reset")

func _ready():
	difficulty_modifier = 1
	score = 0
	hunger = 60
	hunger_cap = 100
	protection = false
	ded = false
	game_start = false
	food_timer.wait_time = 3

func _process(delta):
	
	if game_start == false:
		return
	
	if ded != true:
		difficulty_modifier = (difficulty_modifier + score/10000 * delta) 
		hunger_speed = 0.05 * (difficulty_modifier)
		hunger = hunger - (hunger_speed)
		food_timer.wait_time = 3 / difficulty_modifier
	
	if hunger_cap > 550:
		hunger_cap = 550

	if hunger >= hunger_cap or hunger <= 0:
		if protection != true and hunger > hunger_cap and ded == false:
			ded = true
			game_over()
		
		if hunger <= 0 and ded == false:
			ded = true
			game_over()
		
		if protection == true and hunger >= hunger_cap:
			hunger = hunger_cap * 0.9
			protection = false

func game_over():
	var canvas_layer = get_tree().current_scene.get_node("CanvasLayer")
	
	state_chart.send_event("die")
	
	music_player.volume_db = -10
	var death_anim = get_tree().create_timer(2)
	
	await death_anim.timeout
	
	if canvas_layer.has_node("EldenRingDeath") or canvas_layer.has_node("MortisDeath"):
		return
	
	var random_death = randi_range(1, 3)
	var chosen_death
	
	match random_death:
		1:
			chosen_death = elden_ring_death
		2:
			chosen_death = mortis_death
		3:
			chosen_death = normal_death
	
	print("GAME OVER!")
	
	if score > high_score:
		high_score = score
	#%StateChart.send_event("die")
	var death_screen = chosen_death.instantiate()
	canvas_layer.add_child(death_screen)

func show_restart():
	restart_button.show()
