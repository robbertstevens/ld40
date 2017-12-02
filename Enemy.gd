extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 500
var target = Vector2()
var direction = Vector2()
var attack_range = 40

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	target = get_local_mouse_pos()
	direction = target.normalized() * speed * delta
	direction  = get_direction()
	move(direction)
	
func special_effects():
	print("1")
	