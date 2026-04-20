extends Node2D

signal ended
var tutorial_ended = false
var instruments = ["ARO", "CAIXA", "BUMBO"]
var current_instrument = 0
var btn_color = ["red", "blue", "red"]
var must_leave = false

signal aro_ended(pontos)
signal caixa_ended(pontos)
signal bumbo_ended(pontos)


var showed_aro1 = false
var showed_bumbo1 = false
var showed_caixa1 = false

var pontos = 0
var was_pressed = false
var total_notas = 0
var compasso_ended = false

# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (seminima)
# d - pausa de 3 quartos de tempo
# p - pausa de meio tempo (colcheia)
# D - pausa de 1 quarto de tempo (semicolcheia)

# ARO - z - meio tempo (colcheia) de aro 

var compasso_aro1 = "zpzppzpz"
var compasso_aro2 = "pzpzpzzp"
var compasso_aro3 = "zpzppzpz"
var compasso_aro4 = "pzpzpzzp"
var compasso_aro5 = "zpzppzpz"
var compasso_aro6 = "pzpzpzzp"
var compasso_aro7 = "zpzppzpz"
var compasso_aro8 = "pzpzO"

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

# BUMBO - y - meio tempo (colcheia) de bumbo
# BUMBO - Y - um tempo (seminima) de bumbo

var compasso_bumbo1 = "yppYpyp"
var compasso_bumbo2 = "OO"
var compasso_bumbo3 = "yppYpyp"
var compasso_bumbo4 = "PypO"
var compasso_bumbo5 = "yppYpyp"
var compasso_bumbo6 = "OPpy"
var compasso_bumbo7 = "YpypyY"
var compasso_bumbo8 = "OO"


func music_according_to_phase():
	if current_instrument == 0:
		return [compasso_aro1, compasso_aro2, compasso_aro3, compasso_aro4,
				compasso_aro5, compasso_aro6, compasso_aro7, compasso_aro8]
	if current_instrument == 1:
		return  [compasso_caixa1, compasso_caixa2, compasso_caixa3, compasso_caixa4,
				compasso_caixa5, compasso_caixa6, compasso_caixa7, compasso_caixa8]
	return [compasso_bumbo1, compasso_bumbo2, compasso_bumbo3, compasso_bumbo4, 
			compasso_bumbo5, compasso_bumbo6, compasso_bumbo7, compasso_bumbo8]



func current_audio_sem_solo():
	return "res://sounds/FASE3/100BPM/LOOPS/FASE3_LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE3/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Aro1.hide()
	$Caixa1.hide()
	$Bumbo1.hide()
	hide_all_touch()
	$Compassos.set_music(music_according_to_phase())
	$Pontuacao.hide()
	$PreJogo.hide()

func hide_all_touch():
	$TouchAro1.hide()
	$TouchCaixa1.hide()
	$TouchBumbo1.hide()


func init_phase_buttons(btns):
	print("init_phase_button", btns)
	var i = 0
	for b in btns:
		i = i+1
		var obj = get_node(b)
		print("res://sounds/FASE3/100BPM/ONE_SHOTS/" + instruments[current_instrument] + str(i) + ".mp3")
		obj.set_stream("res://sounds/FASE3/100BPM/ONE_SHOTS/" + instruments[current_instrument] + str(i) + ".mp3")
		obj.set_texture("res://img/mpc-button-" + btn_color[current_instrument] +".png")
		obj.set_volume(30)
		obj.show()

func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(30)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(10)
	if current_instrument >= len(instruments):
		ended.emit()
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.set_first_screen("res://img/tutorial1.jpeg", "voce vai tocar um sample digital!")
		$Tutorial.set_second_screen("res://img/tutorial2.jpeg", "dispare sons previamente gravados")
		$Tutorial.set_show_telas(true)
		$Aro1.show()
		$Tutorial.start()
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
		return p - 100
	return p
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_compassos_seta_moved(current_note: Variant) -> void:
	update_touch(current_note)
	was_pressed = false
	total_notas = total_notas+1
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
	if note == "y" || note == "Y":
		if showed_bumbo1:
			$TouchBumbo1.texture = load("res://img/touch.png")
		else:
			$TouchBumbo1.texture = load("res://img/touch_double.png")
		showed_bumbo1 = !showed_bumbo1
		$TouchBumbo1.show()

func end():
	$AudioSemSolo.stop()
	$AudioMestra.stop()
	$Compassos.hide()
	$MPCBackground.hide()
	$Aro1.hide()
	$Caixa1.hide()
	$Bumbo1.hide()
	hide()


func _on_tutorial_ended() -> void:
	if current_instrument > 3:
		compasso_ended = true
		ended.emit()
		return
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(30)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(10)
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()

func instrument_time():
	if current_instrument == 0:
		return 0.12
	if current_instrument == 1:
		return 0.1
	return 0.1


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
	if current_instrument == 2:
		btns = ["Bumbo1"]
		$Compassos.set_note_width(60)
		$Bumbo1.show()
	init_phase_buttons(btns)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_pre_jogo_countdown_show() -> void:
	$Aro1.hide()
	$Caixa1.hide()
	$Bumbo1.hide()
	if current_instrument == 0:
		$Aro1.show()
	if current_instrument == 1:
		$Caixa1.show()
	if current_instrument == 2:
		$Bumbo1.show()
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
	$Pontuacao.show()


func _on_pre_jogo_ended() -> void:
	if current_instrument >= len(instruments):
		compasso_ended = true
		ended.emit()
		return
	$Compassos.start_timer(instrument_time())
	$AudioSemSolo.play()
		


func _on_compassos_ended() -> void:
	$Pontuacao.hide()
	$Aro1.hide()
	$Bumbo1.hide()
	$Caixa1.hide()
	hide_all_touch()
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0%"
		if current_instrument == 0:
			$PreJogo.set_first_screen("res://img/pre-jogo-aro1.png", "aperte o botao em destaque quando piscar")
			$PreJogo.set_second_screen("res://img/pre-jogo-aro2.png", "bora tocar um pouco de aro!")
		if current_instrument == 1:
			$PreJogo.set_first_screen("res://img/pre-jogo-caixa1.png", "aperte o botao em destaque quando piscar")
			$PreJogo.set_second_screen("res://img/pre-jogo-caixa2.png", "sua vez de tocar caixa!")
		if current_instrument == 2:
			$PreJogo.set_first_screen("res://img/pre-jogo1.png", "aperte o botao em destaque quando piscar")
			$PreJogo.set_second_screen("res://img/pre-jogo2.png", "sua vez de tocar bumbo!")
		
		$PreJogo.show()
		$PreJogo.start()
		return
		
	if current_instrument == 0: 
		aro_ended.emit(get_percent())
	if current_instrument == 1:
		caixa_ended.emit(get_percent())
	if current_instrument == 2:
		bumbo_ended.emit(get_percent())
		
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
		$Tutorial.set_first_screen("res://img/tutorial-caixa1.png", "agora vamos usar o som da caixa!")
		$Tutorial.set_second_screen("res://img/tutorial-caixa2.png", "veja como se faz")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
		$PreJogo.set_show_telas(true)
		$Aro1.hide()
	if current_instrument == 2:
		# Start bumbo		
		$Pontuacao.hide()
		$TouchCaixa1.hide()
		$Tutorial.set_first_screen("res://img/tutorial-bumbo1.png", "agora vamos tocar bumbo!")
		$Tutorial.set_second_screen("res://img/tutorial-bumbo2.png", "veja como se faz")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
		$PreJogo.set_show_telas(true)
		$Caixa1.hide()
	if current_instrument == 3:
		end()
		ended.emit()


func _on_caixa_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "x" || curr_note == "X": 
		update_pontos()


func _on_bumbo_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "y" || curr_note == "Y": 
		update_pontos()


func _on_aro_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "z": 
		update_pontos()
