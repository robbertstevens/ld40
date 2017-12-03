extends Node2D

var enemy_scene = preload("res://enemy/Enemy.tscn")
var boss_scene = preload("res://enemy/Boss.tscn")

var spawn_enemy_count = 0
var difficulty = 1
var to_spawn_point = Vector2()

var count_down_timer
var animation
var sounds

func _ready():
	set_process(true)
	count_down_timer = get_node("Timer")
	animation = get_node("Animation")
	sounds = get_node("Sounds")
	count_down_timer.connect("timeout", self, "_spawn_enemy")

func _process(delta):
	if !sounds.is_voice_active(0) and !sounds.is_voice_active(2) and spawn_enemy_count:
		sounds.play("portalactive")

func spawn_enemies(to_spawn_point, enemy_count, spawn_difficulty):
	spawn_enemy_count = spawn_enemy_count
	spawn_enemy_count = enemy_count
	difficulty = spawn_difficulty
	
	# start timer to spawn enemy
	count_down_timer. set_wait_time(rand_range(1,2))
	count_down_timer.set_active(true)
	count_down_timer.start()
	
	# Start portal animation
	animation.play("fade")
	sounds.play("portalopen")
	
func _spawn_enemy():
	var enemy = enemy_scene.instance()
	enemy.set_pos(get_global_pos())
	get_tree().get_root().get_node("Level").add_child(enemy)
	spawn_enemy_count -= 1
	
	if spawn_enemy_count >= 1:
		count_down_timer. set_wait_time(rand_range(0.5,1.5))
		count_down_timer.set_active(true)
		count_down_timer.start()
	
	if spawn_enemy_count <= 0:
		animation.play_backwards("fade")