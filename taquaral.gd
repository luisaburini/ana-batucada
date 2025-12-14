extends Node2D

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.hide()
	$TextureRect.hide()
	$TrianguloControls.hide()

func _start() -> void:
	show()
	$TextureRect.show()
	$TrianguloControls.show()
	$TrianguloControls.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_controls_ended() -> void:
	$TrianguloControls.end()
	$Score.set_pontos($TrianguloControls.get_pontos())
	$Score.show()


func _on_score_next() -> void:
	$Score.set_pontos($TrianguloControls.get_pontos())
	$TrianguloControls.hide()
	$TrianguloControls.end()
	hide()
	emit_signal("finished")


func _on_score_reset() -> void:
	$Score.set_pontos($TrianguloControls.get_pontos())
	$TrianguloControls.reset()
