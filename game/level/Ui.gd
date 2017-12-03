extends CanvasLayer

var pause_label
var game_over_label

var game_running = false

func _ready():
	pause_label = get_node("pause")
	game_over_label = get_node("game_over")
	pause_label.set_opacity(0)
	game_over_label.set_opacity(0)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("key_exit"):
		get_tree().quit()
	
	if event.is_action("start_game") and not game_running:
		game_running = true
		game_over_label.set_opacity(0)
		get_tree().reload_current_scene()
		get_tree().set_pause(false)
	
	if event.is_action_released("pause_game") and game_running:
		var pause = not get_tree().is_paused()
		get_tree().set_pause(pause)
		
		if pause:
			pause_label.set_opacity(1)
		else:
			pause_label.set_opacity(0)

func game_over():
	game_running = false
	get_tree().set_pause(true)
	game_over_label.set_opacity(1)
	