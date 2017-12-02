extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = 1000 #speed of the bullet
var target = Vector2()
var motion = Vector2()

func _ready():
	set_fixed_process(true)
	target = get_viewport().get_mouse_pos()
	
func _fixed_process(delta):
	motion = target.normalized() * speed * delta
	move(motion)
	
	if is_colliding():
		var collider = get_collider()
		if not collider.is_in_group("player"):
			collider.queue_free()