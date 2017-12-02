extends KinematicBody2D

var path = []
var speed = 50
var sprite_node
var health = 100

func _ready():
	set_fixed_process(true)
	sprite_node = get_node("Sprite")
	get_node("ProgressBar").set_max(health)

func _fixed_process(delta):
	get_node("ProgressBar").set_value(health)
	if (health < 0):
		queue_free()
	
	var navigation = get_tree().get_root().get_node("Level/Navigation")
	var player = get_tree().get_root().get_node("Level/Player")
	path = navigation.get_simple_path(get_global_pos(), player.get_global_pos())
	
	if path.size() > 1:
		var distance = path[1] - get_global_pos()
		var direction = distance.normalized()
		
		var movement_remainder = move(direction * speed * delta)
		var angle = atan2(direction.x, direction.y)
		sprite_node.set_rot(angle)
		
		if is_colliding():
			var normal = get_collision_normal()
			var final_movement = normal.slide(movement_remainder)
			final_movement = speed * delta * final_movement
			move(final_movement)
	