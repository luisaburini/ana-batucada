extends Node2D

var counter = 2
var current_sound = ""
signal ended


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	if counter > 0:
		$Label.text = str(counter)
		counter = counter-1
		$Timer.start()
		return
	ended.emit()
	hide()
		
func set_stream(path):
	current_sound = path
	$AudioLoader.load_audio(path)
	$AudioLoader.play()

func _on_mp_3_loader_finished():
	$Label.show()
	$Timer.start()
