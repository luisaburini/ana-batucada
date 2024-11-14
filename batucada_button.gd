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
	$AudioLoader.load_audio(path)
	
	
func set_event_to_catch(to_catch):
	event_to_catch = to_catch
	
func _input(event):
	if event.is_action_pressed(event_to_catch):
		_on_texture_button_pressed()

func _on_texture_button_pressed():
	if current_sound != "":
		$AudioLoader.play()
	pressed.emit()

func set_volume(volume):
	$AudioLoader.set_volume(volume)
