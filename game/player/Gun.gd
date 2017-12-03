extends Node2D

onready var bullet_scene = preload("res://player/Bullet.tscn")

var delay = .015 # secconds
var last_shot = 0

func _ready():
	set_process(true)
	
func _process(delta):
	var player = get_tree().get_root().get_node("Level/Player")
	
	last_shot -= delta
	var shoot = last_shot <= 0
	var has_ammo = player.ammo > 0
	
	if not has_ammo && shoot && Input.is_mouse_button_pressed(BUTTON_LEFT):
		last_shot = delay
		get_node("SamplePlayer").play("noammo")
		return
	
	if shoot && Input.is_mouse_button_pressed(BUTTON_LEFT):
		var bullet = bullet_scene.instance()
		var player_pos = player.get_pos()
		var direction = (get_global_pos() - player_pos)
		
		bullet.direction = direction.normalized()
		bullet.set_pos(get_global_pos())
		
		last_shot = delay
		player.ammo -= 1
		
		get_node("SamplePlayer").play("shot")
		get_tree().get_root().add_child(bullet)
	
	