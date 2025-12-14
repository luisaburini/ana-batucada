extends TouchScreenButton

var event_to_catch = ""

signal event_pressure(pressure)
signal event_action_strength(strength)

func _input(event):
	if event:
		#print("TOUCH SCREEN BUTTON ")
		#print("event action strength")
		#print(event.get_action_strength("down"))
		emit_signal("event_action_strength", event.get_action_strength("down"))
		if event is InputEventMouseMotion:
			#print("event pressure")
			#print(event.pressure)
			emit_signal("event_pressure", event.pressure)
		if event.is_action_pressed(event_to_catch):
			_on_texture_pressed()

func _set_event_to_catch(to_catch):
	event_to_catch = to_catch

func _on_texture_pressed() -> void:
	print("felt it in the texture!")
