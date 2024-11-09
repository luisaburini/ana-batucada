extends Node2D

#var static_music = "AASSBBSSCCSSDDSSCCAASSBBSSCCSSDDSS"
var static_music = "AASSBBSSCCSSDDSS"
var current_arrow_pos = 0
var current_music_pos = 0
var compasso_size = 16
var finished = false
signal ended

# Called when the node enters the scene tree for the first time.
func _ready():
	update_compasso()


func start_timer():
	$TimerSeta.start()

func _on_timer_timeout():
	if !finished:
		# update arrow position
		current_music_pos = current_music_pos+1
		print("Current music pos " + str(current_music_pos))
		if current_music_pos < len(static_music):
			current_arrow_pos = (current_arrow_pos+1)%compasso_size
			var note = get_note(current_music_pos)
			if note != null:
				$Seta.position.x = note.global_position.x
				if current_arrow_pos == compasso_size:
					current_arrow_pos = 0
					update_compasso()
		else:
			finished = true
			$TimerSeta.stop()
			ended.emit()


func get_note(i):
	var hbox_index = (i/4)%(compasso_size)
	if has_node("HBoxContainer" + str(hbox_index)):
		print("HBoxContainer" + str(hbox_index))
		var parent = get_node("HBoxContainer" + str(hbox_index))
		var index = 4*((i/4)%compasso_size)+current_music_pos%4
		print("Note" + str(index))
		if parent.has_node("Note" + str(index)):
			return parent.get_node("Note" + str(index))
	return null

func get_current_note():
	return static_music[current_music_pos]

func update_compasso():
	for i in range(5):
		if has_node("HBoxContainer" + str(i)):
			var parent = get_node("HBoxContainer" + str(i))
			for j in range(5):
				var index = int(current_music_pos/compasso_size) + 4*i + j
				if parent.has_node("Note" + str(index)):
					if index < len(static_music):
						var note = parent.get_node("Note" + str(index))
						note.texture = load("res://img/"+ static_music[index] +".png")
					else:
						var empty_node = "S"
						var note = parent.get_node("Note" + str(index))
						note.texture = load("res://img/"+ empty_node +".png")
						
