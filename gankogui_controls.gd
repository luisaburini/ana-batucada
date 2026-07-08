extends Node2D

signal ended(pontos)
signal play_ambient()
signal stop_ambient()

var instruments = ["GANKOGUI"]
var current_instrument = 0
var was_pressed = false
var tutorial_ended = false
var already_played = false
var must_leave = false
var total_notas = 0
var pontos = 0
var _is_tutorial = false

# GANKOGUI - g - meio tempo (colcheia)
# GANKOGUI - G - 3 quartos de tempo (colcheia pontuada)

# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (semínima)
# d - pausa de 3 quartos de tempo
# p - pausa de meio tempo (colcheia)
# D - pausa de 1 quarto de tempo (semicolcheia)

var gankogui_compasso1 = "GgDgpgP"
var gankogui_compasso2 = "GgDgO"
var gankogui_compasso3 = "GgDgpgP"
var gankogui_compasso4 = "GgDgO"
var gankogui_compasso5 = "GgDgpgP"
var gankogui_compasso6 = "GgDgO"
var gankogui_compasso7 = "GgDgpgP"
var gankogui_compasso8 = "GgDgO"

var current_sheet = [gankogui_compasso1, gankogui_compasso2, gankogui_compasso3, gankogui_compasso4,
					 gankogui_compasso5, gankogui_compasso6, gankogui_compasso7, gankogui_compasso8,
					 gankogui_compasso1]

func music_according_to_phase():
	return current_sheet

func start():
	$Compassos/Partitura.set_current_fase("Fase2Agogo", 0.6)
	$Compassos/Partitura.reset()
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(30)
	if current_instrument >= len(instruments):
		ended.emit(get_percent())
		return
	was_pressed = false
	if !tutorial_ended:
		$Compassos.set_is_tutorial(true)
		_is_tutorial = true
		$Tutorial.set_instruction_node("AfroHouseGankogui")
		$Tutorial.set_first_screen("res://img/tutorial.jpeg", "Clique no agogô para tocar.
Primeiro eu toco, depois você me acompanha.")
		$Tutorial.set_show_telas(true)
		$Gankogui1Audio.load_audio("")
		$Tutorial.start()
		stop_ambient.emit()
		$Compassos.set_music(music_according_to_phase())
		$Compassos.reset()

func current_audio_sem_solo():
	return "res://sounds/FASE2/100BPM/LOOPS/LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE2/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Compassos.note_width = 42
	$TouchGankogui1.hide()

	$PreJogo.set_first_screen("res://img/pre-jogo.png", "Agora é sua vez de tocar!")
	$Pontuacao.hide()
	$PreJogo.hide()

func update_pontos():
	pontos = pontos+1
	$Pontuacao.text = str(get_percent()) + "%"

func get_percent():
	if total_notas == 0:
		return 0
	if 100*pontos/total_notas > 100:
		return 100
	return 100*pontos/total_notas
	
func get_pontos():
	return pontos

func instrument_time():
	return 0.112
	
func end():
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tutorial_ended() -> void:
	$Gankogui1Audio.load_audio("res://sounds/FASE2/100BPM/ONE_SHOT/GANKOGUI1.mp3")
	$Gankogui1Audio.set_volume(40)
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()
	play_ambient.emit()


func _on_tutorial_countdown_show() -> void:
	$Compassos/Partitura.set_current_fase("Fase2Agogo", 0.6)
	$Compassos/Partitura.reset()
	$Gankogui1Audio.load_audio("res://sounds/FASE2/100BPM/ONE_SHOT/GANKOGUI1.mp3")
	$Gankogui1Audio.set_volume(40)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_pre_jogo_countdown_show() -> void:
	$Compassos/Partitura.set_current_fase("Fase2Agogo", 0.6)
	$Compassos/Partitura.reset()
	$Gankogui1Audio.load_audio("res://sounds/FASE2/100BPM/ONE_SHOT/GANKOGUI1.mp3")
	$Gankogui1Audio.set_volume(40)
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
	


func _on_pre_jogo_ended() -> void:
	$Gankogui1Audio.load_audio("res://sounds/FASE2/100BPM/ONE_SHOT/GANKOGUI1.mp3")
	$Gankogui1Audio.set_volume(40)
	_is_tutorial = false
	$Compassos.set_is_tutorial(false)
	$Pontuacao.show()
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
	play_ambient.emit()


func _on_gankogui_1_pressed() -> void:
	$TouchGankogui1.show()
	$Gankogui1Audio.play()
	if not _is_tutorial:
		Input.vibrate_handheld(500)


func _on_compassos_seta_moved(current_note: Variant) -> void:
	if current_note == "p" or current_note == "P" or current_note == "d" or current_note == "D" or current_note == "O":
		update_pontos()
	$TouchGankogui1.hide()
	total_notas = total_notas+1
	if  current_note == "G" || current_note == "g":
		$TouchGankogui1.show()
		update_pontos()

func reset():
	pontos = 0
	$Compassos.reset()
	start()
	show()


func _on_compassos_ended() -> void:
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0"
		$TouchGankogui1.hide()
		$PreJogo.show()
		$Gankogui1Audio.load_audio("")
		$PreJogo.start()
		stop_ambient.emit()
		return
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	tutorial_ended = false
	must_leave = false
	ended.emit(get_percent())
	$Pontuacao.text = "0"
	pontos = 0
	end()
