extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_hud_init():
	$HUD.hide()
	$Controls.start()



func _on_controls_ended():
	$Controls.end()
	$Score.set_pontos($Controls.get_pontos())
	$Score.show()


func _on_score_reset():
	$Score.set_pontos($Controls.get_pontos())
	$Controls.reset()


func _on_score_next():
	$Score.set_pontos($Controls.get_pontos())
	$Controls.next()
