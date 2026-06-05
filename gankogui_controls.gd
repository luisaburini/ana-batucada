extends Node2D

signal ended(pontos)
var instruments = ["GANKOGUI"]
var current_instrument = 0
var was_pressed = false
var tutorial_ended = false
var already_played = false
var must_leave = false
var total_notas = 0
var pontos = 0

# GANKOGUI - g - meio tempo (colcheia)
# GANKOGUI - G - 3 quartos de tempo (colcheia ponto)

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
					 gankogui_compasso5, gankogui_compasso6, gankogui_compasso7, gankogui_compasso8]

func music_according_to_phase():
	return current_sheet

func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(30)
	if current_instrument >= len(instruments):
		ended.emit(get_percent())
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.set_instruction_node("AfroHouseGankogui")
		$Tutorial.set_first_screen("res://img/tutorial-gankogui1.png", "o som agora e do agogo")
		$Tutorial.set_second_screen("res://img/tutorial-gankogui2.png", "sente so como a Mestra faz")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
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

	$PreJogo.set_first_screen("res://img/pre-jogo-gankogui1.png", "bora tocar um pouco")
	$PreJogo.set_second_screen("res://img/pre-jogo-gankogui2.png", "clique no agogo para tocar!")
	$Pontuacao.hide()
	$PreJogo.hide()

func update_pontos():
	if $Compassos.is_playing():
		pontos = pontos+1
		$Pontuacao.text = str(get_percent()) + "%"

func get_percent():
	if total_notas == 0:
		return 0
	return 100*pontos/total_notas
	
func get_pontos():
	return pontos

func instrument_time():
	return 0.09

func end():
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tutorial_ended() -> void:
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()


func _on_tutorial_countdown_show() -> void:
	$Gankogui1Audio.load_audio("res://sounds/FASE2/100BPM/ONE_SHOT/GANKOGUI1.mp3")
	$Gankogui1Audio.set_volume(40)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_pre_jogo_countdown_show() -> void:
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
	


func _on_pre_jogo_ended() -> void:
	$Pontuacao.show()
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()


func _on_gankogui_1_pressed() -> void:
	$TouchGankogui1.show()
	$Gankogui1Audio.play()


func _on_compassos_seta_moved(current_note: Variant) -> void:
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
