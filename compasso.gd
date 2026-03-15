extends Node2D
var current_music = []
var current_compasso = 0
var index_in_compasso = 0
var finished = false
signal ended
signal seta_moved(current_note)
var timer_seta_seconds = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()

func set_music(music):
	current_music = music
	update_compasso()

func reset():
	$Seta.position.x = 50
	finished = false
	index_in_compasso = 0
	current_compasso = 0
	update_compasso()

func start_timer(seconds):
	if seconds > 0:
		timer_seta_seconds = seconds
		$TimerSeta.start(timer_seta_seconds)
		reset()
	else:
		print("Time is invalid " + str(seconds))

func is_semi_colcheia(note):
	if note == "G":
		return true
	return false

func is_colcheia_dot(note):
	if note == "N":
		return true
	return false

func is_colcheia(note):
	if note == "b" || note == "p" || note == "O":
		return true
	return false
	
func is_seminima(note):
	if note == "B" || note == "B" || note == "C":
		return true
	return false

var times_playing_seminima = 0
var times_playing_colcheia_dot = 0
var times_playing_colcheia = 0


func _on_timer_timeout():
	if len(current_music) == 0:
		return
	if !finished:
		#print(current_music[current_compasso][index_in_compasso])
		if is_seminima(current_music[current_compasso][index_in_compasso]) &&  times_playing_seminima < 4:
			times_playing_seminima = times_playing_seminima+1
			return
		
		if is_colcheia_dot(current_music[current_compasso][index_in_compasso]) && times_playing_colcheia_dot < 3:
			times_playing_colcheia_dot = times_playing_colcheia_dot+1
			return
			
		if is_colcheia(current_music[current_compasso][index_in_compasso]) && times_playing_colcheia < 2:
			times_playing_colcheia = times_playing_colcheia+1
			return
		
		index_in_compasso = index_in_compasso+1
		times_playing_seminima = 0
		times_playing_colcheia = 0
		times_playing_colcheia_dot = 0
		
		if index_in_compasso == len(current_music[current_compasso]):
			index_in_compasso = 0
			current_compasso = current_compasso+1
		
		if current_compasso == len(current_music):
			finished = true
			$TimerSeta.stop()
			ended.emit()
			return
		
		
		var note = get_current_note() 
		if note != null:
			$Seta.position.x = note.global_position.x+52
			seta_moved.emit(str(current_music[current_compasso][index_in_compasso]))
			if current_compasso > 0 && current_compasso%4 == 0:
				update_compasso()
		else:
			print("GET CURRENT NOTE IS NULL")
	else:
		finished = true
		$TimerSeta.stop()
		ended.emit()

func get_previous_note():
	if index_in_compasso == 0 && current_compasso > 0:
		return current_music[current_compasso-1][len(current_music[current_compasso-1])-1]
	if current_compasso < len(current_music) && index_in_compasso < len(current_music[current_compasso]):
		return current_music[current_compasso][index_in_compasso-1]
	return "P"

func get_current_note_name():
	if current_compasso < len(current_music) && index_in_compasso < len(current_music[current_compasso]):
		return current_music[current_compasso][index_in_compasso]
	return "P"

func get_current_note():
	var pentagrama = get_node("HBoxContainer")
	if pentagrama.has_node("Compasso" + str(current_compasso%4)):
		var parent = pentagrama.get_node("Compasso" + str(current_compasso%4))
		
		if parent.has_node("Note" + str(index_in_compasso)):
			return parent.get_node("Note" + str(index_in_compasso))
	return null


func update_compasso():
	if current_music == null:
		return 
	if len(current_music) == 0:
		return
	
	var pentagrama = get_node("HBoxContainer")
	if pentagrama == null:
		return
	
	
	for i in range (0, 4):
		var compasso_nome = "Compasso" + str(i)
		if pentagrama.has_node(compasso_nome):
			var compasso = pentagrama.get_node(compasso_nome)
			for j in range (0, 15):
				if current_compasso+i < len(current_music):
					if compasso.has_node("Note"+str(j)):
						var note = compasso.get_node("Note"+str(j))
						if j < len(current_music[current_compasso+i]):
							note.texture = load("res://img/"+current_music[current_compasso+i][j] +".png")
						continue
				var note = compasso.get_node("Note"+str(j))
				note.texture = load("")
				
			
	if current_compasso >= len(current_music):
		return
		
	var notes_in_compasso = len(current_music[current_compasso])
	for i in range(notes_in_compasso+1):
		if has_node("HBoxContainer" + str(i)):
			var parent = get_node("HBoxContainer" + str(i))
			for j in range(notes_in_compasso+1):
				var index = notes_in_compasso*i + j
				if parent.has_node("Note" + str(index)):
					if index < len(current_music):
						var note = parent.get_node("Note" + str(index))
						note.texture = load("res://img/"+ current_music[current_compasso][index_in_compasso] +".png")
					else:
						var empty_node = "P"
						var note = parent.get_node("Note" + str(index))
						note.texture = load("res://img/"+ empty_node +".png")
						
