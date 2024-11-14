extends Node2D

signal reset
signal next

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_pontos(pontos):
	$Label.text = str(pontos)


func _on_texture_button_pressed():
	reset.emit()
	hide()

func _on_next_button_pressed():
	next.emit()
	hide()
