extends Node2D

var delay = .5 # secconds
var last_shot = 0
onready var bullet_scene = preload("res://player/Bullet.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
	
func _process(delta):
	last_shot -= delta
	var shoot = last_shot <= 0
	if (shoot && Input.is_mouse_button_pressed(BUTTON_LEFT)):
		var bullet = bullet_scene.instance()
		bullet.direction = (get_global_pos() - get_tree().get_root().get_node("Level/Player").get_pos()).normalized()
		bullet.set_pos(get_global_pos())
		last_shot = delay
		get_tree().get_root().add_child(bullet)
	
		
		
