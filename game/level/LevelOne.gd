extends Node2D

var currentRoom
var start_time
var time_elapsed
var spawns
var generator
var ui

var max_enemy_count = 3
var enemy_spawn_rate = 3

func _ready():
	generator = get_node("Navigation/Generator")
	ui = get_node("Ui")
	ui.game_running = true
	set_process(true)
	start_time = OS.get_unix_time()

	spawns = get_tree().get_nodes_in_group("spawn")
	for spawn in spawns:
		spawn.spawn_enemies(generator.get_global_pos(), 2, 1)

func _process(delta):
	time_elapsed = OS.get_unix_time()
		
	# Healt update
	var player = get_tree().get_root().get_node("Level/Player")
	var healthBar = get_tree().get_root().get_node("Level/Ui/HealthBar")
	
	healthBar.set_value(player.health)
	
	# Ammo update
	var ammoValue = get_tree().get_root().get_node("Level/Ui/AmmoValueLabel")
	ammoValue.set_text(str(player.ammo))
	
	# Score update
	var scoreValue = get_tree().get_root().get_node("Level/Ui/ScoreValueLabel")
	scoreValue.set_text(str(player.score))