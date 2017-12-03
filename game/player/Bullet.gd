extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = 1000 #speed of the bullet
var direction = Vector2()
var target = Vector2()
var motion = Vector2()
var max_damage = 100



func _ready():
	set_process(true)
	target =  - get_pos()
	
func _process(delta):
	motion = direction * speed * delta
	move(motion)
	
	if is_colliding():
		var collider = get_collider()
		
		if collider.is_in_group("enemy"):
			collider.health -= get_damage()
			
		if not collider.is_in_group("player"):
			queue_free()
			
func get_damage():
	var ammo = get_tree().get_root().get_node("Level/Player").ammo
	var dmg = max_damage - ammo
	dmg = clamp(dmg, 1, 100)
	print(dmg)
	return dmg;