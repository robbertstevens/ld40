extends "Enemy.gd"

onready var fire = preload("res://enemy/FireDrop.tscn")

var drop_interval = .5
var last_drop = 0

func _ready():
	speed = 50
	health = 250
	._ready()

func _fixed_process(delta):
	._fixed_process(delta)
	
	last_drop -= delta
	
	if last_drop < 0 && not has_near_fire(): 
		
		var drop = fire.instance()
		drop.set_pos(get_global_pos())
		last_drop = drop_interval
		
		get_tree().get_root().add_child(drop)

func has_near_fire():
	var fires = get_tree().get_nodes_in_group("fire")
	
	for fire in fires:
		if (get_pos() - fire.get_pos()).length() < 5:
			return true
	
	return false

func get_damage():
	return 25