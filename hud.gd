extends Node2D

signal init

func _on_button_pressed():
	print("pressed button init")
	init.emit()
