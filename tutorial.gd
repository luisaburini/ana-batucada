extends Node2D

var counter = 0
var max = 5
var current_sound = ""
signal ended


# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func start():
	$AudioLoader.set_volume(20)
	$Label.hide()
	$AnimatedSprite2D.play()
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	counter = counter+1
	if counter < max:
		$Label.text = str(counter)
		$Timer.start()
		print(counter)
		return
	ended.emit()
	hide()
	$Timer.set_one_shot(true)
	$Timer.stop()
		
func set_stream(path):
	current_sound = path
	$AudioLoader.load_audio(path)
	$AudioLoader.play()

func _on_mp_3_loader_finished():
	$Label.show()
	$Timer.start()
