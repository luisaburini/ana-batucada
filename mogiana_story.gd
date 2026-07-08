extends Node2D

var baloon = 0
signal ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready baloon 0")
	baloon = 0
	$TextureRect.texture = load("res://img/Conversas/Conversaestadio1.jpg")
	$TextureRect.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	$CLickAudio.load_audio("res://sounds/CLICK.mp3")
	$CLickAudio.set_volume(30)
	$Timer.autostart = false
	$Timer.one_shot = true
	baloon = 0
	print("start baloon 0")
	$Timer.start(1)


func _on_timer_timeout() -> void:
	$Timer.start(3)
	baloon = baloon+1
	print("timer timeout baloon ", baloon)
	if baloon >= 1 and baloon <= 5:
		$TextureRect.texture = load("res://img/Conversas/Conversaestadio"+str(baloon)+".jpg")
		return
	if baloon == 6:
		$Timer.stop()
		ended.emit()


func _on_touch_screen_button_pressed() -> void:
	$CLickAudio.play()
	$Timer.stop()
	ended.emit()
