extends Node2D

signal finished
var current_phase = 0
var is_show = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Score.hide()
	$Background.hide()
	$Controls.hide()

func _start() -> void:
	show()
	$Background.show()
	$Controls.show()
	$Controls.start()


func _on_controls_ended() -> void:
	$Controls.end()
	$Controls.hide()
	$Score.set_pontos($Controls.get_percent())
	if $Controls.get_percent() < 50:
		$Score.hide_next()
	if is_show:
		finished.emit()
		$Background.hide()
		hide()
	else:
		$Score.show()


func _on_score_next() -> void:
	print("on score next")
	is_show = true
	$Score.set_pontos(0)
	if current_phase > 1:
		$Controls.hide()
		$Controls.end()
		hide()
		print("FINISHED")
		emit_signal("finished")
		return
	current_phase = current_phase+1
	$Controls.set_phase(current_phase)
	$Controls.reset()


func _on_score_reset() -> void:
	print("on score reset")
	is_show = false
	$Score.set_pontos(0)
	$Score.hide()
	$Controls.reset()
