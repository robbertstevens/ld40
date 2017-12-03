extends KinematicBody2D

var path = []
var speed = 100
var sprite_node
var health = 100
var damage = 5
var last_shot = 0
var delay = 0.5
var player
var navigation
var lootbox_scene = preload("res://lootbox/Lootbox.tscn")
var lootbox_spawned = false

func _ready():
	set_process(true)
	sprite_node = get_node("Sprite")
	player = get_tree().get_root().get_node("Level/Player")
	navigation = get_tree().get_root().get_node("Level/Navigation")

func _process(delta):
	
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
	
	path = navigation.get_simple_path(get_global_pos(), player.get_global_pos())
	
	if path.size() > 1:
		var distance = path[1] - get_global_pos()
		var direction = distance.normalized()
		
		var movement_remainder = move(direction * speed * delta)
		var angle = atan2(direction.x, direction.y)
		sprite_node.set_rot(angle)
		
		if is_colliding():
			var normal = get_collision_normal()
			var final_movement = normal.slide(movement_remainder)
			final_movement = speed * delta * final_movement
			move(final_movement)
	