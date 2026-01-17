extends Node2D

signal init
var repeat_music = true

func _on_button_pressed():
	print("pressed button init")
	repeat_music = false
	$AudioStreamPlayer2D.stop()
	init.emit()


func _on_audio_stream_player_2d_finished():
	if repeat_music:
		$AudioStreamPlayer2D.play()
