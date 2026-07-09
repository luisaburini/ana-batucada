extends Node2D

signal ended
signal aro_ended(pontos)
signal caixa_ended(pontos)
signal play_ambient()
signal stop_ambient()

var tutorial_ended = false
var instruments = ["ARO", "CAIXA"]
var current_instrument = 0
var must_leave = false
var showed_aro1 = false
var showed_caixa1 = false
var pontos = 0
var was_pressed = false
var total_notas = 0
var compasso_ended = false

# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (seminima)
# p - pausa de meio tempo (colcheia)

# ARO - z - meio tempo (colcheia) de aro 

var compasso_aro1 = "zpzppzpz"
var compasso_aro2 = "pzpzpzzp"
var compasso_aro3 = "zpzppzpz"
var compasso_aro4 = "pzpzpzzp"
var compasso_aro5 = "zpzppzpz"
var compasso_aro6 = "pzpzpzzp"
var compasso_aro7 = "zpzppzpz"
var compasso_aro8 = "pzpzO   "

# CAIXA - x - meio tempo (colcheia) de caixa
# CAIXA - X - 1 tempo (seminima) de caixa
var compasso_caixa1 = "OXP"
var compasso_caixa2 = "OXP"
var compasso_caixa3 = "OXP"
var compasso_caixa4 = "OxxX"
var compasso_caixa5 = "OXP"
var compasso_caixa6 = "OxxX"
var compasso_caixa7 = "OxxP"
var compasso_caixa8 = "OxxX"
var compasso_caixa9 = "OXP"
var compasso_caixa10 = "OXP"
var compasso_caixa11 = "OXP"
var compasso_caixa12 = "OxxX"
var compasso_caixa13 = "OXP"


func music_according_to_phase():
	if current_instrument == 0:
		return [compasso_aro1, compasso_aro2, compasso_aro3, compasso_aro4,
				compasso_aro5, compasso_aro6, compasso_aro7, compasso_aro8]
	if current_instrument == 1:
		return  [compasso_caixa1, compasso_caixa2, compasso_caixa3, compasso_caixa4,
				compasso_caixa5, compasso_caixa6, compasso_caixa7, compasso_caixa8,
				compasso_caixa9, compasso_caixa10, compasso_caixa11, compasso_caixa12,
				compasso_caixa13 ]

func current_audio_sem_solo():
	return "res://sounds/FASE1/100BPM/LOOPS/FASE1_LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE1/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MPCBackground.show()
	$Compassos.show()
	$Tutorial._ready()
	$PreJogo._ready()
	tutorial_ended = false
	instruments = ["ARO", "CAIXA"]
	current_instrument = 0
	must_leave = false
	showed_aro1 = false
	showed_caixa1 = false
	pontos = 0
	was_pressed = false
	total_notas = 0
	compasso_ended = false
	$Aro1.set_texture("res://img/mpb-button-green.png")
	$Aro1.hide()
	$Caixa1.set_texture("res://img/mpb-button-green.png")
	$Caixa1.hide()
	hide_all_touch()
	$Compassos/Partitura.set_current_fase("Fase1Aro", 0.6)
	$Compassos.set_music(music_according_to_phase())
	$Pontuacao.hide()
	$PreJogo.hide()

func hide_all_touch():
	$TouchAro1.hide()
	$TouchCaixa1.hide()


func init_phase_buttons(btns):
	print("init_phase_button", btns)
	var i = 0
	for b in btns:
		i = i+1
		var obj = get_node(b)
		print("res://sounds/FASE1/100BPM/ONE_SHOTS/" + instruments[current_instrument] + str(i) + ".mp3")
		obj.set_stream("res://sounds/FASE1/100BPM/ONE_SHOTS/" + instruments[current_instrument] + str(i) + ".mp3")
		obj.set_texture("res://img/mpc-button-green.png")
		obj.set_volume(40)
		obj.show()

func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(30)
	if current_instrument >= len(instruments):
		ended.emit()
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.set_instruction_node("SambaTrapAro")
		$Compassos.set_is_tutorial(true)
		$Aro1.set_is_tutorial(true)
		$Tutorial.reset()
		$Tutorial.set_first_screen("res://img/tutorial.jpeg", "Clique no botão do sample de aro para tocar.
Siga a bolinha branca que dá o ritmo.
Primeiro eu toco, depois você me acompanha.")
		$Tutorial.set_show_telas(true)
		$Aro1.show()
		stop_ambient.emit()
		$Tutorial.start()
		$Compassos/Partitura.set_current_fase("Fase1Aro", 0.6)
		$Compassos.set_music(music_according_to_phase())
		$Compassos.reset()

func reset():
	pontos = 0
	total_notas = 0
	was_pressed = false
	compasso_ended = false
	$Pontuacao.text = "0%"
	$AudioSemSolo.stop()
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$Compassos.reset()
	$Compassos.show()
	$MPCBackground.show()
	if current_instrument == 0:
		$Compassos.note_width = 70
	start()
	show()


func update_pontos():
	if $Compassos.is_playing() && !was_pressed: 
		Input.vibrate_handheld(100)
		pontos = pontos+1
		if total_notas > 0:
			$Pontuacao.text = str(get_percent()) + "%"
		was_pressed = true

func get_pontos():
	return pontos

func get_percent():
	if total_notas == 0:
		return 0
	var p = 100*pontos/total_notas
	if p > 100:
		return 100
	return p
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_compassos_seta_moved(current_note: Variant) -> void:
	update_touch(current_note)
	was_pressed = false
	total_notas = total_notas+1
	if current_note == "p" or current_note =="P" or current_note == "d" or current_note == "D" or current_note == "O":
		pontos = pontos+1
	$Pontuacao.text = str(get_percent()) + "%"
	
func update_touch(note):
	hide_all_touch()
	if note == "z":
		if showed_aro1:
			$TouchAro1.texture = load("res://img/touch.png")
		else:
			$TouchAro1.texture = load("res://img/touch_double.png")
		showed_aro1 = !showed_aro1
		$TouchAro1.show()
		return
	if note == "x" || note == "X":
		if showed_caixa1:
			$TouchCaixa1.texture = load("res://img/touch.png")
		else:
			$TouchCaixa1.texture = load("res://img/touch_double.png")
		showed_caixa1 = !showed_caixa1
		$TouchCaixa1.show()
		return

func end():
	$AudioSemSolo.stop()
	$AudioMestra.stop()
	$Compassos.hide()
	$MPCBackground.hide()
	$Aro1.hide()
	$Caixa1.hide()
	hide()

func _on_tutorial_ended() -> void:
	play_ambient.emit()
	if current_instrument > 3:
		compasso_ended = true
		ended.emit()
		return
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(30)
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()

func instrument_time():
	if current_instrument == 0:
		return 0.10
	if current_instrument == 1:
		return 0.123
	return 0.08


func _on_tutorial_countdown_show() -> void:
	hide_all_touch()
	var btns = []
	if current_instrument == 0:
		btns = ["Aro1"]
		$Compassos.set_note_width(52)
		$Aro1.show()
	if current_instrument == 1:
		btns = ["Caixa1"]
		$Compassos.set_note_width(60)
		$Caixa1.show()
	init_phase_buttons(btns)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_pre_jogo_countdown_show() -> void:
	$Tutorial.hide()
	$Aro1.hide()
	$Caixa1.hide()
	if current_instrument == 0:
		$Aro1.show()
	if current_instrument == 1:
		$Caixa1.show()
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
	$Pontuacao.show()


func _on_pre_jogo_ended() -> void:
	play_ambient.emit()
	$Compassos.set_is_tutorial(false)
	$Aro1.set_is_tutorial(false)
	$Caixa1.set_is_tutorial(false)
	$Compassos/Partitura.reset()
	if current_instrument >= len(instruments):
		compasso_ended = true
		ended.emit()
		return
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
		


func _on_compassos_ended() -> void:
	$Pontuacao.hide()
	$Aro1.hide()
	$Caixa1.hide()
	hide_all_touch()
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0%"
		if current_instrument == 0:
			$PreJogo.set_first_screen("res://img/pre-jogo.png", "Agora é sua vez de tocar!")
			$Compassos/Partitura.set_current_fase("Fase1Aro", 0.6)
		if current_instrument == 1:
			$PreJogo.set_first_screen("res://img/pre-jogo.png", "Agora é sua vez de tocar!")
			$Compassos/Partitura.set_current_fase("Fase1Caixa", 0.6)
		$Compassos/Partitura.reset()
		$PreJogo.show()
		$PreJogo.reset()
		stop_ambient.emit()
		$PreJogo.start()
		return
		
	if current_instrument == 0: 
		aro_ended.emit(get_percent())
	if current_instrument == 1:
		caixa_ended.emit(get_percent())
		
	current_instrument = current_instrument+1
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	tutorial_ended = false
	must_leave = false
	$Pontuacao.text = "0%"
	pontos = 0
	$Compassos.set_music(music_according_to_phase())
	$Compassos.reset()
	
	if current_instrument == 1:
		# Start caixa
		$Pontuacao.hide()
		$TouchAro1.hide()
		$Aro1.hide()
		$Compassos.set_is_tutorial(true)
		$Caixa1.set_is_tutorial(true)
		$Tutorial.set_instruction_node("SambaTrapCaixa")
		$Tutorial.reset()
		$Compassos/Partitura.set_current_fase("Fase1Caixa", 0.6)
		$Compassos/Partitura.reset()
		$Tutorial.set_first_screen("res://img/tutorial.jpeg", "Clique no botão do sample de caixa para tocar.
Siga a bolinha branca que dá o ritmo.
Primeiro eu toco, depois você me acompanha.")
		$Tutorial.set_show_telas(true)
		stop_ambient.emit()
		$Tutorial.start()
		$PreJogo.set_show_telas(true)
	if current_instrument == 2:
		end()
		ended.emit()


func _on_caixa_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "x" || curr_note == "X": 
		update_pontos()


func _on_aro_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "z": 
		update_pontos()


func _on_audio_mestra_finished() -> void:
	if !compasso_ended:
		$AudioMestra.play()


func _on_audio_sem_solo_finished() -> void:
	if !compasso_ended:
		$AudioSemSolo.play()
