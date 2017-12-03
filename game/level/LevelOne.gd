extends Node2D

var start_time
var time_elapsed
var spawns
var generator

# wave variables
var wave_interval = 10
var wave_number = 1
var last_wave_spawn = 0

func _ready():
	generator = get_node("Navigation/Generator")
	set_process(true)
	start_time = OS.get_unix_time()

func _process(delta):
	time_elapsed = OS.get_unix_time()
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
		
	# Healt update
	var player = get_tree().get_root().get_node("Level/Player")
	var healthBar = get_tree().get_root().get_node("Level/UI/HealthBar")
	
	healthBar.set_value(player.health)
	
	# Ammo update
	var ammoValue = get_tree().get_root().get_node("Level/UI/AmmoValueLabel")
	ammoValue.set_text(str(player.ammo))
	
	# Score update
	var scoreValue = get_tree().get_root().get_node("Level/UI/ScoreValueLabel")
	scoreValue.set_text(str(player.score))
	
	last_wave_spawn -= delta
	if last_wave_spawn < 0:
		wave_number += 1
		last_wave_spawn = wave_interval
		spawn_waves()
	
func spawn_waves():
	spawns = get_tree().get_nodes_in_group("spawn")
	for spawn in spawns:
		spawn.spawn_enemies(generator.get_global_pos(), wave_number)