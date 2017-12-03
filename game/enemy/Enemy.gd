extends KinematicBody2D

var path = []
var speed = 100
var sprite_node
var health = 100
var damage = 5
var last_shot = 0
var delay = 0.5
var player
var generator
var navigation
var lootbox_scene = preload("res://lootbox/Lootbox.tscn")
var lootbox_spawned = false
var target
var chasing


func _ready():
	set_fixed_process(true)
	sprite_node = get_node("Sprite")
	player = get_tree().get_root().get_node("Level/Player")
	navigation = get_tree().get_root().get_node("Level/Navigation")
	generator = navigation.get_node("Generator")
	path = navigation.get_simple_path(get_global_pos(), generator.get_global_pos(), true)
	target = 0
	chasing = false

func _fixed_process(delta):
	if (health <= 0):
		if (!lootbox_spawned):
			lootbox_spawned = true
			var lootbox = lootbox_scene.instance()
			lootbox.set_global_pos(get_global_pos())
			get_tree().get_root().get_node("Level").add_child(lootbox)
		queue_free()

	last_shot -= delta
	if ((player.get_pos() - get_pos()).length() < 44 && last_shot <= 0):
		player.health -= 5
		last_shot = delay
	
	if ((generator.get_pos() - get_pos()).length() < 100 && last_shot <= 0):
		generator.add_damage(20)
		last_shot = delay
	
	if !chasing && (get_pos() - player.get_pos()).length() < 200:
		chasing = true
	elif chasing && (get_pos() - player.get_pos()).length() > 400:
		chasing = false
		path = navigation.get_simple_path(get_global_pos(), generator.get_global_pos(), true)
		target = 0
	
	var direction = Vector2(0,0)
	if chasing:
		direction = (player.get_pos() - get_pos()).normalized()
	elif path.size() > target:
		var distance = path[target] - get_global_pos()
		direction = distance.normalized()

		if (path[target] - get_global_pos()).length() < 30:
			target += 1

	var movement_remainder = move(direction * speed * delta)
	var angle = atan2(direction.x, direction.y)
	sprite_node.set_rot(angle)
	
	if is_colliding():
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		final_movement = speed * delta * final_movement
		move(final_movement)