extends KinematicBody2D

var sprite_node
var animation

var input_x_direction = 0
var x_direction = 0

var input_y_direction = 0
var y_direction = 0

const MAX_SPEED = 200
const ACCELERATION = 2600
const DECELERATION = 5000

var speed = Vector2()
var velocity = Vector2()

var ammo = 50
var health = 100
var score = 0

func _ready():
	set_process(true)
	sprite_node = get_node("Sprite")
	animation = get_node("Animation")
	
func _process(delta):
	if (health < 0):
		get_tree().get_root().get_node("Level/Ui").game_over()

	# X movement
	if input_x_direction:
		x_direction = input_x_direction
	
	if Input.is_action_pressed("move_left"):
		input_x_direction = -1
	elif Input.is_action_pressed("move_right"):
		input_x_direction = 1
	else:
		input_x_direction = 0
	
	if input_x_direction == - x_direction:
		speed.x /= 3
	if input_x_direction:
		speed.x += ACCELERATION * delta
	else:
		speed.x -= DECELERATION * delta
	speed.x = clamp(speed.x, 0, MAX_SPEED)
	
	# Y movement
	if input_y_direction:
		y_direction = input_y_direction
		
	if Input.is_action_pressed("move_up"):
		input_y_direction = -1
	elif Input.is_action_pressed("move_down"):
		input_y_direction = 1
	else:
		input_y_direction = 0
	
	if input_y_direction == - y_direction:
		speed.y /= 3
	if input_y_direction:
		speed.y += ACCELERATION * delta
	else:
		speed.y -= DECELERATION * delta
	speed.y = clamp(speed.y, 0, MAX_SPEED)

	velocity = Vector2(speed.x * delta * x_direction, speed.y * delta * y_direction)
	var movement_remainder = move(velocity)
	
	
	if (input_x_direction or input_y_direction) and not animation.is_playing():
		animation.play("walk")
	if not (input_x_direction or input_y_direction):
		animation.stop()
 
	if is_colliding():
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		speed = normal.slide(speed)
		move(final_movement)
		var c = get_collider()

	# sprite direction
	var mouse_pos = get_local_mouse_pos()
	var angle = atan2(mouse_pos.x, mouse_pos.y)
	sprite_node.set_rot(angle)
	
	#if speed.length() > 0: 
	#	get_node("SamplePlayer").play("footsteps")