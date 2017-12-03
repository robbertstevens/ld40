extends Node2D

var start_time
var time_elapsed
var spawns
var generator
var ui

var player
var ammoValue
var healthBar
var scoreValue
var waveValue
var nextWaveValue
var generatorBar

# wave variables
var wave_interval = 15
var wave_number = 0
var last_wave_spawn = 0

func _ready():
	generator = get_node("Navigation/Generator")
	player = get_tree().get_root().get_node("Level/Player")
	
	generatorBar = get_tree().get_root().get_node("Level/Ui/GeneratorBar")
	ammoValue = get_tree().get_root().get_node("Level/Ui/AmmoValueLabel")
	healthBar = get_tree().get_root().get_node("Level/Ui/HealthBar")
	scoreValue = get_tree().get_root().get_node("Level/Ui/ScoreValueLabel")
	waveValue = get_tree().get_root().get_node("Level/Ui/WaveValueLabel")
	nextWaveValue = get_tree().get_root().get_node("Level/Ui/NextWaveValueLabel")
	
	ui = get_node("Ui")
	ui.game_running = true
	set_process(true)
	start_time = OS.get_unix_time()

func _process(delta):
	time_elapsed = OS.get_unix_time()
		
	# Healt update
	healthBar.set_value(player.health)
	# Ammo update
	ammoValue.set_text(str(player.ammo))
	# Score update
	scoreValue.set_text(str(player.score))
	# wave update
	waveValue.set_text(str(wave_number))
	# gen update
	generatorBar.set_value(generator.health)
	
	last_wave_spawn -= delta
	if last_wave_spawn < 0:
		if wave_number % 5 == 0:
			player.max_damage *= 2
		player.score += wave_number * 100
		wave_number += 1
		last_wave_spawn = wave_interval
		spawn_waves()
	
	# next wave update
	nextWaveValue.set_text(str(ceil(last_wave_spawn)))
	
func spawn_waves():
	spawns = get_tree().get_nodes_in_group("spawn")
	for spawn in spawns:
		spawn.spawn_enemies(generator.get_global_pos(), wave_number)
