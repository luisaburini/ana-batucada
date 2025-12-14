extends Node2D

signal init

func _on_button_pressed():
	print("pressed button init")
	$AudioStreamPlayer2D.stop()
	init.emit()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
