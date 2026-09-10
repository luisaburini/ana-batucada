extends Node2D

var baloon = 0
var language = "pt"

signal ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready baloon 0")
	baloon = 0
	$AudioLoader.load_audio("res://sounds/CLICK.mp3")
	$AudioLoader.set_volume(20)
	$Background.texture = load("res://img/Conversas/Conversaconchaacustica1"+language+".jpg")
	$Background.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start(lang):
	language = lang
	print("res://img/pular_nova-campinas-"+lang+".png")
	$TouchScreenButton.texture_normal = load("res://img/pular_nova-campinas-"+lang+".png")
	print("res://img/Conversas/Conversaconchaacustica1-"+lang+".jpg")
	$Background.texture = load("res://img/Conversas/Conversaconchaacustica1-"+lang+".jpg")
	$Timer.autostart = false
	$Timer.one_shot = true
	baloon = 0
	print("start baloon 0")
	$Timer.start(1)


func _on_timer_timeout() -> void:
	$Timer.start(6)
	baloon = baloon+1
	print("timer timeout baloon ", "res://img/Conversas/Conversaconchaacustica"+str(baloon)+"-"+language+".jpg")
	if baloon >= 1 and baloon <= 5:
		$Background.texture = load("res://img/Conversas/Conversaconchaacustica"+str(baloon)+"-"+language+".jpg")
		return
	if baloon == 6:
		$Timer.stop()
		ended.emit()


func _on_touch_screen_button_pressed() -> void:
	$Timer.stop()
	ended.emit()
	$AudioLoader.play()
