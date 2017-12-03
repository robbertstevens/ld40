extends "Enemy.gd"

func _ready():
	speed = 50
	health = 250
	._ready()

func _fixed_process(delta):
	._fixed_process(delta)
	

func get_damage():
	return 25