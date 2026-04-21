extends Node2D


signal ended(pontos)
var instruments = ["PALMAS"]
var current_instrument = 0
var was_pressed = false
var tutorial_ended = false
var already_played = false
var must_leave = false
var total_notas = 0
var pontos = 0
var showed_palmas = false


# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (semínima)
# d - pausa de 3 quartos de tempo
# p - pausa de meio tempo (colcheia)
# D - pausa de 1 quarto de tempo (semicolcheia)

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
					 compasso_palmas1, compasso_palmas2, compasso_palmas3, compasso_palmas4,
					 compasso_palmas5, compasso_palmas6, compasso_palmas7, compasso_palmas8]

func music_according_to_phase():
	return current_sheet

func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(30)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(30)
	if current_instrument >= len(instruments):
		ended.emit(get_percent())
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.set_instruction_node("SammbaTrapPalmas")
		$Tutorial.set_first_screen("res://img/tutorial-palmas1.png", "o som agora e das palmas")
		$Tutorial.set_second_screen("res://img/tutorial-palmas2.png", "sente so como a Mestra faz")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
		$Compassos.set_music(music_according_to_phase())
		$Compassos.reset()


func current_audio_sem_solo():
	return "res://sounds/FASE3/100BPM/LOOPS/FASE3_LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE3/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Compassos.note_width = 42
	$TouchPalmas.hide()
	$PreJogo.set_first_screen("res://img/pre-jogo-palmas1.png", "bora tocar um pouco")
	$PreJogo.set_second_screen("res://img/pre-jogo-palmas2.png", "clique para bater palmas!")
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
	return 0.07


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
	$PalmasAudio.load_audio("res://sounds/FASE3/100BPM/ONE_SHOTS/PALMAS.mp3")
	$PalmasAudio.set_volume(30)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_pre_jogo_ended() -> void:
	$Pontuacao.show()
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()


func _on_pre_jogo_countdown_show() -> void:
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()


func _on_palmas_pressed() -> void:
	$PalmasAudio.play()
	$TouchPalmas.show()


func _on_compassos_ended() -> void:
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0"
		$TouchPalmas.hide()
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


func reset():
	pontos = 0
	$Compassos.reset()
	start()
	show()


func _on_compassos_seta_moved(current_note: Variant) -> void:
	$TouchPalmas.hide()
	total_notas = total_notas+1
	if  current_note == "k":
		if showed_palmas:
			$TouchPalmas.texture = load("res://img/touch.png")
		else:
			$TouchPalmas.texture = load("res://img/touch-double.png")
		$TouchPalmas.show()
		update_pontos()
