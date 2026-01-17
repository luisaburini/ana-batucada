extends Node2D

signal ended
signal hide_next

var phases = ["FASE1_60BPM", "FASE1_90BPM"]
var bpms = [60, 90]
var current_phase = 0
var pontos = 0
var was_pressed = false
var total_notas = 0
var show_tutorial = true
var compasso_ended = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioLoader.load_audio("res://sounds/" + phases[current_phase] + "_MUSICA.wav")
	$AudioLoader.set_volume(20)
	var btns = ["red", "pink", "green"]
	for b in btns:
		var obj = get_node(b)
		obj.set_stream("res://sounds/" + b + ".wav")
		obj.set_texture("res://img/mpc-button-"+b+".png")
		obj.set_event_to_catch("pressed_" + b)
		obj.set_volume(30)
	
func start():
	if current_phase >= len(phases):
		ended.emit()
		return
	was_pressed = false
	if !show_tutorial:
		$Tutorial.set_show_telas(false)
	print("START MPC CONTROLS ", current_phase, " ", "res://sounds/" + phases[current_phase] + "_MUSICA.wav")
	$AudioLoader.load_audio("res://sounds/" + phases[current_phase] + "_MUSICA.wav")
	$Tutorial.start()

func set_phase(phase):
	current_phase = phase
	
func get_phase():
	return current_phase
	
func next():
	current_phase = (current_phase+1)%len(phases)
	$Compasso.reset()
	start()
	show()
	
func reset():
	pontos = 0
	total_notas = 0
	was_pressed = false
	compasso_ended = false
	$Pontuacao.text = "0%"
	$AudioLoader.stop()
	$Compasso.reset()
	$Compasso.show()
	$MPCBackground.show()
	$red.show()
	$pink.show()
	$green.show()
	show_tutorial = false
	start()
	show()

func update_pontos():
	pontos = pontos+1
	if total_notas > 0:
		$Pontuacao.text = str(get_percent()) + "%"
	was_pressed = true

func _on_compasso_ended():
	compasso_ended = true
	$AudioLoader.stop()
	ended.emit()
	
func get_pontos():
	return pontos

func get_percent():
	if total_notas == 0:
		return 0
	return 100*pontos/total_notas

func _on_compasso_seta_moved(note):
	update_touch(note)
	if !was_pressed and str(note) == "P":
		update_pontos()
	was_pressed = false
	total_notas = total_notas+1
	$Pontuacao.text = str(get_percent()) + "%"
	
func update_touch(note):
	if note == "W":
		#print("note is red")
		$TouchRed.show()
		$TouchPink.hide()
		$TouchGreen.hide()
		return
	if note == "O":
		#print("note is pink")
		$TouchRed.hide()
		$TouchPink.show()
		$TouchGreen.hide()
		return
	if note == "L":
		#print("note is green")
		$TouchRed.hide()
		$TouchPink.hide()
		$TouchGreen.show()
		return
	$TouchRed.hide()
	$TouchPink.hide()
	$TouchGreen.hide()
	#print("no note, wait")

func end():
	$AudioLoader.stop()
	hide()
	$Compasso.hide()
	$MPCBackground.hide()
	$red.hide()
	$pink.hide()
	$green.hide()
	$TouchGreen.hide()
	$TouchPink.hide()
	$TouchRed.hide()
	$Tutorial.hide()
	
func _on_tutorial_ended():
	print("Tutorial ended ", current_phase)
	if current_phase > 1:
		compasso_ended = true
		$AudioLoader.stop()
		ended.emit()
		return
	$AudioLoader.play()
	$Compasso.start_timer(bpms[current_phase])

func _on_w_pressed():
	if $Compasso.get_current_note() == "W":
		update_pontos()


func _on_o_pressed():
	if $Compasso.get_current_note() == "O":
		update_pontos()


func _on_l_pressed():
	if $Compasso.get_current_note() == "L":
		update_pontos()
		
func _on_mp_3_loader_finished():
	print("MPC CONTROLS AUDIO ENDED")
	if !compasso_ended:
		$AudioLoader.play()
	


func _on_tutorial_countdown_show() -> void:
	$Compasso.start_timer(bpms[current_phase])
	$AudioLoader.play()
