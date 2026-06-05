extends Node2D

signal init

func _on_button_pressed():
	print("pressed button init")
	$ButtonClick.load_audio("res://sounds/CLICK.mp3")
	$ButtonClick.play()
	$ButtonClick.set_volume(30)
	init.emit()
