extends Node2D

signal init

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_button_pressed():
	$AudioStreamPlayer2D.stop()
	init.emit()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
