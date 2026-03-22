extends Node2D

signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	$TextureRect.hide()
	hide()
	
func _start() -> void:
	print("START ESTACAO CULTURA")
	show()
	$TextureRect.show()
	$Controls.show()
	$Controls.start()


func _on_controls_ended() -> void:
	$Controls.end()
	$TextureRect.hide()
