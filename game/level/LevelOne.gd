extends Node2D

var currentRoom
var start_time
var time_elapsed

var max_enemy_count = 3
var enemy_spawn_rate = 3

var enemy_scene = preload("res://enemy/Enemy.tscn")

func _ready():
	set_process(true)
	start_time = OS.get_unix_time()
	
	for room in get_tree().get_nodes_in_group("room"):
		room.connect("body_enter", self, "_enter_roomOne", [room])
	
	for spawn in get_tree().get_nodes_in_group("spawn"):
		var enemy = enemy_scene.instance()
		enemy.set_pos(spawn.get_global_pos())
		get_tree().get_root().get_node("Level").add_child(enemy)

func _process(delta):
	time_elapsed = OS.get_unix_time()
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
		
	# Healt update
	var player = get_tree().get_root().get_node("Level/Player")
	var healthBar = get_tree().get_root().get_node("Level/UI/HealthBar")
	
	healthBar.set_value(player.health)
	

func _enter_roomOne(body, room):
	if body.is_in_group("player"):
		currentRoom = room