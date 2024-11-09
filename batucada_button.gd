extends Node2D

var current_sound = ""
signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureButton.hide()
	$Label.hide()


func set_text(text):
	$Label.text = text
	$Label.show()
	
func set_texture(path):
	$TextureButton.texture_normal = load(path)
	$TextureButton.show()


func set_stream(path):
	current_sound = path
	var snd_file = FileAccess.open(path, FileAccess.READ)
	var stream = AudioStreamMP3.new()
	stream.data = FileAccess.get_file_as_bytes(path)
	snd_file.close()
	$AudioStreamPlayer2D.stream = stream
	


func _on_texture_button_pressed():
	if current_sound != "":
			$AudioStreamPlayer2D.play()
	pressed.emit()
