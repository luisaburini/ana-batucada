extends Node2D
var current_music = "OPOWPPWPLPWLOPPP"
var current_arrow_pos = 0
var current_music_pos = 0
var compassos_size = 16
var notes_in_compasso = 4
var finished = false
signal ended
signal seta_moved(current_note)

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

func set_music(music):
	current_music = music

func set_compassos_size(comp_size):
	compassos_size = comp_size

func reset():
	$Seta.position.x = 50
	finished = false
	current_arrow_pos = 0
	current_music_pos = 0
	update_compasso()

func start_timer(bpm):
	if bpm > 0:
		$TimerSeta.start(-1+float(60/(2*bpm)))
	else:
		print("BPM is invalid " + str(bpm))

func _on_timer_timeout():
	if !finished:
		# update arrow position
		current_music_pos = current_music_pos+1
		if current_music_pos < len(current_music):
			current_arrow_pos = (current_arrow_pos+1)%compassos_size
			var note = get_note(current_music_pos)
			if note != null:
				$Seta.position.x = note.global_position.x+50
				seta_moved.emit(str(current_music[current_music_pos]))
				if current_arrow_pos == 0:
					update_compasso()
		else:
			finished = true
			$TimerSeta.stop()
			ended.emit()

func get_previous_note():
	if current_music_pos > 0:
		return current_music[current_music_pos-1]
	return "P"


func get_note(i):
	var hbox_index = int(i/notes_in_compasso)%notes_in_compasso
	if has_node("HBoxContainer" + str(hbox_index)):
		var parent = get_node("HBoxContainer" + str(hbox_index))
		var index = (notes_in_compasso*((i/notes_in_compasso)%compassos_size)+current_music_pos%notes_in_compasso)%compassos_size
		if parent.has_node("Note" + str(index)):
			return parent.get_node("Note" + str(index))
	return null

func get_current_note():
	if current_music_pos < len(current_music):
		return current_music[current_music_pos]
	return "P"

func update_compasso():
	for i in range(notes_in_compasso+1):
		if has_node("HBoxContainer" + str(i)):
			var parent = get_node("HBoxContainer" + str(i))
			for j in range(notes_in_compasso+1):
				var index = notes_in_compasso*i + j
				if parent.has_node("Note" + str(index)):
					if index < len(current_music):
						var note = parent.get_node("Note" + str(index))
						var texture_index = current_music_pos+ notes_in_compasso*i + j
						note.texture = load("res://img/"+ current_music[texture_index] +".png")
					else:
						var empty_node = "P"
						var note = parent.get_node("Note" + str(index))
						note.texture = load("res://img/"+ empty_node +".png")
						
