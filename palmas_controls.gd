extends Node2D

signal ended(pontos)
signal play_ambient()
signal stop_ambient()

var instruments = ["PALMAS"]
var current_instrument = 0
var was_pressed = false
var tutorial_ended = false
var already_played = false
var must_leave = false
var total_notas = 0
var pontos = 0
var showed_palmas = false
var must_vibrate = false

# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (semínima)
# p - pausa de meio tempo (colcheia)

# PALMAS - k - meio tempo (colcheia) de palmas

var compasso_palmas1 = "PkppkP"
var compasso_palmas2 = "kppkO"
var compasso_palmas3 = "PkppkP"
var compasso_palmas4 = "kppkO"
var compasso_palmas5 = "PkppkP"
var compasso_palmas6 = "kppkO"
var compasso_palmas7 = "PkppkP"
var compasso_palmas8 = "kppkO"


var current_sheet = [compasso_palmas1, compasso_palmas2, compasso_palmas3, compasso_palmas4,
					 compasso_palmas5, compasso_palmas6, compasso_palmas7, compasso_palmas8,
					compasso_palmas1, compasso_palmas2]

func music_according_to_phase():
	return current_sheet

func start():
	$Compassos/Partitura.set_current_fase("Fase1Palmas", 0.6)
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(20)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(25)
	if current_instrument >= len(instruments):
		ended.emit(get_percent())
		return
	was_pressed = false
	if !tutorial_ended:
		$Compassos.reset()
		must_vibrate = false
		$Compassos.set_is_tutorial(true)
		$Tutorial.set_instruction_node("SambaTrapPalmas")
		$Tutorial.set_first_screen("res://img/tutorial-palmas1.png", "Para não esquecermos as músicas,
escrevemos partituras.
Quando tem uma nota, tocamos,
quando tem uma pausa, fazemos silêncio.")
		$Tutorial.set_second_screen("res://img/tutorial-palmas2.png", "Eu toco primeiro, depois é a sua vez!
		Habilite a vibração do seu celular e
bora, Ana Batucada!")
		$Tutorial.set_show_telas(true)
		stop_ambient.emit()
		$TouchPalmas.hide()
		$TouchPalmas.texture = load("")
		$PalmasAudio.load_audio("")
		$Tutorial.start()
		$Compassos.set_music(music_according_to_phase())
		


func current_audio_sem_solo():
	return "res://sounds/FASE1/100BPM/LOOPS/FASE1_LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE1/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Compassos.note_width = 42
	$TouchPalmas.texture = load("")
	$TouchPalmas.hide()
	$PreJogo.set_first_screen("res://img/pre-jogo-palmas1.png", "Sua vez, Ana Batucada!
Bora tocar um pouco!")
	$PreJogo.set_second_screen("res://img/pre-jogo-palmas2.png", "Clique para bater palmas!")
	$Pontuacao.hide()
	$PreJogo.hide()

func update_pontos():
	pontos = pontos+1
	$Pontuacao.text = str(get_percent()) + "%"

func get_percent():
	if total_notas == 0:
		return 100
	return 100*pontos/total_notas
	
func get_pontos():
	return pontos

func instrument_time():
	return 0.11


func end():
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tutorial_ended() -> void:
	play_ambient.emit()
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()
	$Compassos.start_timer(instrument_time())


func _on_tutorial_countdown_show() -> void:
	$PalmasAudio.load_audio("res://sounds/FASE1/100BPM/ONE_SHOTS/PALMAS.mp3")
	$PalmasAudio.set_volume(35)
	$Compassos/Partitura.set_current_fase("Fase1Palmas", 0.6)
	$Compassos/Partitura.reset()
	$Pontuacao.hide()
	


func _on_pre_jogo_ended() -> void:
	play_ambient.emit()
	must_vibrate = true
	$Pontuacao.show()
	$AudioSemSolo.play()
	


func _on_pre_jogo_countdown_show() -> void:
	$PalmasAudio.load_audio("res://sounds/FASE1/100BPM/ONE_SHOTS/PALMAS.mp3")
	$PalmasAudio.set_volume(35)
	$Compassos/Partitura.set_current_fase("Fase1Palmas", 0.6)
	$Compassos/Partitura.reset()
	$Compassos.set_is_tutorial(false)
	$Compassos.start_timer(instrument_time())


func _on_palmas_pressed() -> void:
	$PalmasAudio.play()
	$TouchPalmas.show()
	if must_vibrate:
		Input.vibrate_handheld(500)
		print("VIBROU PALMAS")


func _on_compassos_ended() -> void:
	if tutorial_ended && !must_leave:
		$Compassos/Partitura.set_current_fase("Fase1Palmas", 0.6)
		$Compassos/Partitura.reset()
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0"
		$TouchPalmas.hide()
		$TouchPalmas.texture = load("")
		$PalmasAudio.load_audio("")
		$PreJogo.show()
		stop_ambient.emit()		
		$PreJogo.start()
		return
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	tutorial_ended = false
	must_leave = false
	ended.emit(get_percent())
	$Pontuacao.text = "0"
	pontos = 0
	end()


func reset():
	pontos = 0
	$Compassos.reset()
	start()
	show()


func _on_compassos_seta_moved(current_note: Variant) -> void:
	total_notas = total_notas+1
	$TouchPalmas.hide()
	if current_note == "p" or current_note =="P" or current_note == "d" or current_note == "D" or current_note == "O":
		update_pontos()
	if  current_note == "k":
		print("Current note is ", current_note)
		$TouchPalmas.show()
		pontos = pontos+1
		update_pontos()
		if showed_palmas:
			$TouchPalmas.texture = load("res://img/touch.png")
		else:
			$TouchPalmas.texture = load("res://img/touch_double.png")
		showed_palmas = !showed_palmas
		
