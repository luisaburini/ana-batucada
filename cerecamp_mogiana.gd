extends Node2D

signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.hide()
	$Controls.hide()
	$TextureRect.hide()
	
func _start() -> void:
	show()
	$Controls.show()
	$Controls.start()
	$TextureRect.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_controls_ended() -> void:
	$Controls.end()
	$Score.set_pontos($Controls.get_pontos())
	$Score.show()


func _on_score_next() -> void:
	$Score.set_pontos($Controls.get_pontos())
	$Controls.hide()
	$Controls.end()
	hide()
	emit_signal("finished")


func _on_score_reset() -> void:
	$Score.set_pontos($Controls.get_pontos())
	$Controls.reset()
