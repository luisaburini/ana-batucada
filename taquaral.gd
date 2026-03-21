extends Node2D

signal finished
var current_phase = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.hide()
	$FunkMPCControls.hide()
	$FunkTrianguloControls.hide()

func _start() -> void:
	show()
	$Background.show()
	$FunkMPCControls.show()
	$FunkMPCControls.start()


func _on_controls_ended() -> void:
	$FunkMPCControls.end()
	$FunkMPCControls.hide()
	$FunkTrianguloControls.show()
	$FunkTrianguloControls.start()
	


func _on_funk_triangulo_controls_ended() -> void:
	finished.emit()
