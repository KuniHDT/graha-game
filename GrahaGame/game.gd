extends Node2D

func _ready():
	MusicManager.play("bgm", "papaya")
	MusicManager.enable_stem("papaya")
