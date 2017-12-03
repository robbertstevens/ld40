extends CanvasLayer

var pause_label
var game_over_label
var crosshair

var game_running = false

func _ready():
	pause_label = get_node("pause")
	game_over_label = get_node("game_over")
	crosshair = get_node("Crosshair")
	pause_label.set_opacity(0)
	game_over_label.set_opacity(0)
	set_process_input(true)
	set_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var mouse = get_viewport().get_mouse_pos()
	crosshair.set_pos(mouse)

func _input(event):
	if event.is_action_pressed("key_exit"):
		get_tree().quit()
	
	if event.is_action("start_game") and not game_running:
		start_game()
	
	if event.is_action_released("pause_game") and game_running:
		var pause = not get_tree().is_paused()
		get_tree().set_pause(pause)
		
		if pause:
			pause_label.set_opacity(1)
		else:
			pause_label.set_opacity(0)

func start_game():
	game_running = true
	game_over_label.set_opacity(0)
	get_tree().reload_current_scene()
	get_tree().set_pause(false)

func game_over():
	game_running = false
	get_tree().set_pause(true)
	game_over_label.set_opacity(1)
	
func _on_Button_pressed():
	var name = get_tree().get_root().get_node("Level/Ui/game_over/TextEdit").get_text()
	var httpClient = HTTPClient.new()
	httpClient.connect("ld40.robbert.rocks",80)
	while(httpClient.get_status() == HTTPClient.STATUS_CONNECTING or httpClient.get_status() == HTTPClient.STATUS_RESOLVING):
		httpClient.poll()
		print("Connecting...")
		OS.delay_msec(300)
	assert(httpClient.get_status() == HTTPClient.STATUS_CONNECTED)
	var fields = {"name" : name, "score" : get_tree().get_root().get_node("Level/Player").score}
	var queryString = httpClient.query_string_from_dict(fields)
	var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: " + str(queryString.length())]
	var result = httpClient.request(HTTPClient.METHOD_POST,"https://ld40.robbert.rocks/highscore.php", headers, queryString)
	start_game()