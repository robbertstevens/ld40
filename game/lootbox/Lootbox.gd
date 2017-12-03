extends StaticBody2D

var player

func _ready():
	set_process(true)
	player = get_tree().get_root().get_node("Level/Player")
	
func _process(delta):
	if (player.get_global_pos() - get_global_pos()).length() < 50:
		player.ammo += 10
		queue_free()