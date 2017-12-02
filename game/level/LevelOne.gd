extends Node2D

var currentRoom

func _ready():
	set_process(true)
	
	for room in get_tree().get_nodes_in_group("room"):
		room.connect("body_enter", self, "_enter_roomOne", [room])

func _process(delta):
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()

func _enter_roomOne(body, room):
	if body.is_in_group("player"):
		currentRoom = room