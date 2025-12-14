extends Node2D


signal ended
signal hide_next

#var phases = ["FASE1_80BPM", "FASE1_80BPM", "FASE1_85BPM", "FASE1_90BPM"]
var phases = ["FASE1_60BPM"]
var bpms = [60]
var current_phase = 0
var pontos = 0
var was_pressed = false
var played_metronomo = false
var maozinha_solta = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Compasso.start_timer(bpms[current_phase])
	$MetronomoLoader.load_audio("res://sounds/" + phases[current_phase] + "_METRONOMO.wav")
	$MetronomoLoader.set_volume(30)
	$AudioLoader.load_audio("res://sounds/" + phases[current_phase] + "_MUSICA.wav")
	$AudioLoader.play()
	$Metronomo.show()
	#$AnimatedSprite2D.play()
	#_on_tutorial_ended()

func _on_batedor_is_dragging(position: Variant) -> void:
	pass
	#if position.x > 800 and position.x < 1200:
		#print(position)
	
func start():
	was_pressed = false
	played_metronomo = false
	#_on_tutorial_ended()
	#$Tutorial.start()
	#print("Tutorial play " + "res://sounds/" + phases[current_phase] + "_MUSICA_COM_BONGO.wav")
	#$Tutorial.set_stream("res://sounds/" + phases[current_phase] + "_MUSICA_COM_BONGO.wav")
	
func next():
	current_phase = (current_phase+1)%len(phases)
	$Compasso.reset()
	start()
	show()
	
func reset():
	pontos = 0
	$Compasso.reset()
	start()
	show()

var metronomo = false

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
	$MetronomoLoader.stop()
	$AudioLoader.stop()
	hide()
	
func _on_tutorial_ended():
	print("Tutorial ended -> metronomo show")
	$Compasso.start_timer(bpms[current_phase])
	$MetronomoLoader.load_audio("res://sounds/" + phases[current_phase] + "_METRONOMO.wav")
	$MetronomoLoader.set_volume(30)
	$AudioLoader.load_audio("res://sounds/" + phases[current_phase] + "_MUSICA.wav")
	$AudioLoader.play()
	$Metronomo.show()
	


func _on_metronomo_pressed():
	if played_metronomo:
		$MetronomoLoader.stop()
	else:
		$MetronomoLoader.play()
	played_metronomo = !played_metronomo


func _on_metronomo_loader_finished():
	if played_metronomo:
		$MetronomoLoader.play()



func _on_triangulo_entered_embaixo() -> void:
	print("entered embaixo")
	var note = "E"
	if maozinha_solta:
		note = "S"
	if $Compasso.get_current_note() == note:
		update_pontos()
	$TrianguloLoader.set_volume(40)
	$TrianguloLoader.load_audio("./sounds/" + note + ".wav")
	$TrianguloLoader.play()


func _on_triangulo_entered_emcima() -> void:
	print("entered emcima")
	var note = "A"
	if maozinha_solta:
		note = "Z"
	if $Compasso.get_current_note() == note:
		update_pontos()
	$TrianguloLoader.set_volume(40)
	$TrianguloLoader.load_audio("./sounds/" + note + ".wav")
	$TrianguloLoader.play()


func _on_maozinha_pressed() -> void:
	maozinha_solta = !maozinha_solta
	if maozinha_solta:
		$Maozinha.texture_normal = load("res://img/maozinha-solta.png")
	else:
		$Maozinha.texture_normal = load("res://img/maozinha.png")
