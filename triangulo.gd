extends Node2D

signal entered_triangulo()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_touch_screen_button_pressed() -> void:
	emit_signal("entered_triangulo")
