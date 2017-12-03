extends Area2D

var alive_time = 5

func _ready(): 
	set_process(true)
	
func _process(delta):
	alive_time -= delta
	
	if alive_time < 0:
		queue_free()
	
func get_damage():
	return 1
