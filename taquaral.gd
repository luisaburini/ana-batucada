extends Node2D

signal finished
var current_phase = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
