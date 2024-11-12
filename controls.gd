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
		obj.set_stream("res://sounds/" + b + ".mp3")
		obj.set_event_to_catch("pressed_" + b)
		obj.set_texture("res://img/"+b+".png")
	
func start():
	$Tutorial.set_stream("res://sounds/" + phases[current_phase] + "_MUSICA.mp3")

var metronomo = false

func set_metronomo_audio():
	var path = "res://sounds/" + phases[current_phase] + "_METRONOMO.mp3"
	print(path)
	var snd_file = FileAccess.open(path, FileAccess.READ)
	if snd_file != null:
		metronomo = true
		var stream = AudioStreamMP3.new()
		stream.data = FileAccess.get_file_as_bytes(path)
		snd_file.close()
		$AudioStreamPlayer2D.stream = stream
		$AudioStreamPlayer2D.play()

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
	$AudioStreamPlayer2D.stop()
	hide()


func _on_tutorial_ended():
	$Compasso.start_timer(bpms[current_phase])
	set_metronomo_audio()


func _on_audio_stream_player_2d_finished():
	if metronomo:
		$AudioStreamPlayer2D.play()
