extends Node2D

var current_sound = ""
var event_to_catch = ""
signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	$Texture.hide()
	$Label.hide()


func set_text(text):
	$Label.text = text
	$Label.show()
	
func set_texture(path):
	$Texture.texture_normal = load(path)
	$Texture.show()
	$Label.show()


func set_stream(path):
	current_sound = path
	$AudioLoader.load_audio(path)
	
	
func set_event_to_catch(to_catch):
	event_to_catch = to_catch
	$Texture._set_event_to_catch(to_catch)
	

func set_volume(volume):
	$AudioLoader.set_volume(volume)

func _on_texture_pressed() -> void:
	if current_sound != "":
		$AudioLoader.play()
	pressed.emit()


func _on_texture_event_action_strength(strength: Variant) -> void:
	pass
	#print("BATUCADA BUTTON texture event action strength ")
	#$Label.text = "strength="
	#$Label.text += str(strength)


func _on_texture_event_pressure(pressure: Variant) -> void:
	#print("BATUCADA BUTTON texture event PRESSURE ") 
	$Label.text = "pressure="
	$Label.text += str(pressure)
