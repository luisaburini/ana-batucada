extends Node2D

signal ended

var phases = ["FASE1_80BPM", "FASE1_85BPM", "FASE1_90BPM"]
var bpms = [80, 85, 90]
var current_phase = 0
var pontos = 0
var was_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	var btns = ["A", "B", "C", "D"]
	for b in btns:
		var obj = get_node(b)
		obj.set_stream("res://sounds/" + b + ".wav")
		obj.set_texture("res://img/"+b+".png")
		obj.set_event_to_catch("pressed_" + b)
	
func start():
	$Tutorial.set_stream("res://sounds/" + phases[current_phase] + "_MUSICA.wav")

var metronomo = false

func _on_a_pressed():
	if $Compasso.get_current_note() == "A":
		update_pontos()


func _on_b_pressed():
	if $Compasso.get_current_note() == "B":
		update_pontos()


func _on_c_pressed():
	if $Compasso.get_current_note() == "C":
		update_pontos()


func _on_d_pressed():
	if $Compasso.get_current_note() == "D":
		update_pontos()

func update_pontos():
	if !was_pressed:
		pontos = pontos+1
		$Label.text = str(pontos)
		was_pressed = true

func _on_compasso_ended():
	ended.emit()
	
func get_pontos():
	return pontos

func _on_compasso_seta_moved():
	was_pressed = false

func end():
	$AudioLoader.stop()
	hide()
	
func _on_tutorial_ended():
	$Compasso.start_timer(bpms[current_phase])
	$AudioLoader.load_audio("res://sounds/" + phases[current_phase] + "_METRONOMO.wav")
	$AudioLoader.play()


func _on_mp_3_loader_finished():
	if metronomo:
		$MP3Loader.play()
