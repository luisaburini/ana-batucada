extends Node2D

signal ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	$Timer.start(10)
	$AudioLoader.load_audio("res://sounds/CLICK.mp3")
	$AudioLoader.set_volume(20)
	

func _on_timer_timeout() -> void:
	$Timer.stop()
	ended.emit()


func _on_touch_screen_button_pressed() -> void:
	$Timer.stop()
	ended.emit()
	$AudioLoader.play()
