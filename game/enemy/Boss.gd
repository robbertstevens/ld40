extends "Enemy.gd"

var speech_delay = 10
var last_time_spoken = 0
func _ready():
	speed = 50
	health = 250
	
	get_node("SamplePlayer").play("iwillgetyou");
	._ready()

func _fixed_process(delta):
	._fixed_process(delta)
	
	last_time_spoken -= delta

func get_damage():
	return 25