extends Node2D

var current_sound = ""
var event_to_catch = ""
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
	
	
func set_event_to_catch(to_catch):
	event_to_catch = to_catch
	print(to_catch)
	
func _input(event):
	if event.is_action_pressed(event_to_catch):
		print("Pressed " + event_to_catch)
		_on_texture_button_pressed()

func _on_texture_button_pressed():
	if current_sound != "":
			$AudioStreamPlayer2D.play()
	pressed.emit()
