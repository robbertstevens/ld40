extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = 20 #speed of the bullet
var direction = Vector2()
var target = Vector2()
var motion = Vector2()
var max_damage = 100

func _ready():
	set_rot(direction.angle() + PI / 2)
	set_process(true)
	
func _process(delta):
	motion = direction.normalized() * speed * delta
	
	move(motion)
	
	if is_colliding():
		var collider = get_collider()
		
		if collider.is_in_group("enemy"):
			collider.health -= get_damage()
			
		if not collider.is_in_group("player"):
			queue_free()
	
	if Input.is_key_pressed(KEY_E):
		speed = 2
	
	if Input.is_key_pressed(KEY_Q):
		speed = 1000	
func get_damage():
	var ammo = get_tree().get_root().get_node("Level/Player").ammo
	var dmg = max_damage - ammo
	dmg = clamp(dmg, 1, max_damage)
	return dmg;