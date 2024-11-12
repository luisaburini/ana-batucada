extends Node2D

var current_sound = ""
signal ended


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_stream(path):
	current_sound = path
	print(path)
	var snd_file = FileAccess.open(path, FileAccess.READ)
	if snd_file != null:
		var stream = AudioStreamMP3.new()
		stream.data = FileAccess.get_file_as_bytes(path)
		snd_file.close()
		$AudioStreamPlayer2D.stream = stream
		$AudioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished():
	ended.emit()
	hide()
