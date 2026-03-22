extends Node2D

signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Controls.hide()
	$TextureRect.hide()
	
func _start() -> void:
	print("START mogiana")
	show()
	$Controls.show()
	$Controls.start()
	$TextureRect.show()


func _on_controls_ended() -> void:
	$Controls.end()


func _on_score_next() -> void:
	$Controls.hide()
	$Controls.end()
	hide()
	emit_signal("finished")


func _on_score_reset() -> void:
	$Controls.reset()
