extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = 1000 #speed of the bullet
var direction = Vector2()
var target = Vector2()
var motion = Vector2()
var damage = 5



func _ready():
	set_process(true)
	target =  - get_pos()
	
func _process(delta):
	motion = direction * speed * delta
	move(motion)
	
	if is_colliding():
		var collider = get_collider()
		
		if collider.is_in_group("enemy"):
			collider.health -= damage
			
		if not collider.is_in_group("player"):
			queue_free()
		