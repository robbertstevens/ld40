extends "Enemy.gd"

func _ready():
	health = 250
	._ready()

func _fixed_process(delta):
	._fixed_process(delta)