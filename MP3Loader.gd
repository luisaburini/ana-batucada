extends Node2D

var current_sound = ""
signal finished


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_audio(path):
	$AudioStreamPlayer2D.set_stream(load(path))
		
		
func play():
	$AudioStreamPlayer2D.play()

func stop():
	$AudioStreamPlayer2D.stop()

func _on_audio_stream_player_2d_finished():
	finished.emit()
