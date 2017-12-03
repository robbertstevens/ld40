extends StaticBody2D

var health = 1000
var ui
var healthBar

func _ready():
	ui = get_tree().get_root().get_node("Level/Ui")
	healthBar = get_node("HealthBar")
	
	healthBar.set_max(health)
	healthBar.set_value(health)
	
func add_damage(damage):
	health -= damage
	
	healthBar.set_value(health)
	
	if health <= 0:
		ui.game_over()
