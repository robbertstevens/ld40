extends StaticBody2D

var health = 1000
var ui

func _ready():
	ui = get_tree().get_root().get_node("Level/Ui")
	
func add_damage(damage):
	health -= damage
	
	if health <= 0:
		ui.game_over()
