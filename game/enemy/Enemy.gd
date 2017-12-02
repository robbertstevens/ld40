extends KinematicBody2D

var path = []
var speed = 200

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	path = get_node("../Navigation2D").get_simple_path(get_global_pos(), get_node("../Player").get_global_pos())
	
	if path.size() > 1:
		var distance = path[1] - get_global_pos()
		var direction = distance.normalized()
		
		var movement_remainder = move(direction * speed * delta)
	
		if is_colliding():
			var normal = get_collision_normal()
			var final_movement = normal.slide(movement_remainder)
			final_movement = speed * delta * final_movement
			move(final_movement)
	