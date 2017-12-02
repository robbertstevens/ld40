extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var delay = 3000
var last_shot = 0
var speed = 100
onready var bullet_scene = preload("res://Gun.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
	
func _process(delta):
	last_shot -= delta
	var shoot = last_shot <= 0
	if (shoot && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		var bullet = bullet_scene.instance()
		bullet.set_pos(get_pos())
		add_child(bullet)
		last_shot = delay
	
		
		
