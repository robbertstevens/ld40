extends Node2D

var enemy_scene = preload("res://enemy/Enemy.tscn")
var boss_scene = preload("res://enemy/Boss.tscn")
var stalker = preload("res://enemy/Stalker.tscn")

var spawn_enemy_count = 0
var difficulty = 1
var difficulty_modifier = 1.2
var to_spawn_point = Vector2()

var count_down_timer
var animation
var sounds

var active_sounds = []

func _ready():
	set_process(true)
	count_down_timer = get_node("Timer")
	animation = get_node("Animation")
	sounds = get_node("Sounds")
	count_down_timer.connect("timeout", self, "_spawn_enemy")
	active_sounds.append(sounds.play("portalactive"))

func _process(delta):
	if (!sounds.is_voice_active(active_sounds[0]) && spawn_enemy_count):
		active_sounds[0] = sounds.play("portalactive")

func spawn_enemies(to_spawn_point, wave_number):
	spawn_enemy_count = clamp(floor(wave_number * difficulty_modifier), 0, 10)
	difficulty = wave_number
	
	# start timer to spawn enemy
	count_down_timer.set_wait_time(rand_range(1,2))
	count_down_timer.set_active(true)
	count_down_timer.start()
	
	# Start portal animation
	animation.play("fade")
	#active_sounds.append(sounds.play("portalopen"))
	
func _spawn_enemy():
	var ran = round(rand_range(0,3))
	var enemy = enemy_scene.instance()
	if ran == 0:
		enemy = enemy_scene.instance()
	elif ran == 1:
		enemy = boss_scene.instance()
	elif ran == 2:
		enemy = stalker.instance()
		
	enemy.health *= pow(difficulty_modifier, difficulty)
	enemy.set_pos(get_global_pos())
	get_tree().get_root().get_node("Level").add_child(enemy)
	spawn_enemy_count -= 1
	
	if spawn_enemy_count >= 1:
		count_down_timer. set_wait_time(rand_range(0.5,1.5))
		count_down_timer.set_active(true)
		count_down_timer.start()
	
	if spawn_enemy_count <= 0:
		animation.play_backwards("fade")