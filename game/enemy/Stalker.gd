extends "Enemy.gd"

func _ready():
	._ready()
	speed = 250


func get_damage():
	return 3