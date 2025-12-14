extends Node2D

signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.hide()
	$Controls.hide()
	$TextureRect.hide()
	hide()
	
func _start() -> void:
	show()
	$TextureRect.show()
	$Controls.show()
	$Controls.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_controls_ended() -> void:
	$Controls.end()
	$Score.set_pontos($Controls.get_pontos())
	$Score.show()
	$TextureRect.hide()


func _on_score_next() -> void:
	$Score.set_pontos($Controls.get_pontos())
	$Controls.hide()
	$Controls.end()
	emit_signal("finished")


func _on_score_reset() -> void:
	$Score.set_pontos($Controls.get_pontos())
	$Controls.reset()
