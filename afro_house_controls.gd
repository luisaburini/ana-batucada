extends Node2D

signal ended
var tutorial_ended = false
var instruments = ["HIHAT", "BUMBO"]
var current_instrument = 0
var must_leave = false

signal hihat_ended(pontos)
signal bumbo_ended(pontos)

var pontos = 0
var was_pressed = false
var total_notas = 0
var compasso_ended = false


var showed_hihat1 = false
var showed_bumbo1 = false

# O - pausa de 2 tempos (minima)
# P - pausa de 1 tempo (semínima)
# d - pausa de 3 quartos de tempo
# p - pausa de meio tempo (colcheia)
# D - pausa de 1 quarto de tempo (semicolcheia)

# h - hihat de meio tempo (colcheia)
var compasso_hihat1 = "phphphph"
var compasso_hihat2 = "phphphP"
var compasso_hihat3 = "phphphph"
var compasso_hihat4 = "phphphph"
var compasso_hihat5 = "phphphph"
var compasso_hihat6 = "phphphP"
var compasso_hihat7 = "phphphph"
var compasso_hihat8 = "phphphph"

# A - bumbo de 1 tempo (seminima)
# a - bumbo de meio tempo (colcheia)
var compasso_bumbo1 = "AAAA"
var compasso_bumbo2 = "AAaaA"
var compasso_bumbo3 = "AAAA"
var compasso_bumbo4 = "AAaaaa"
var compasso_bumbo5 = "AAAA"
var compasso_bumbo6 = "AAaaA"
var compasso_bumbo7 = "AAAA"
var compasso_bumbo8 = "Aaaaaaa"


func music_according_to_phase():
	if current_instrument == 0:
		return [compasso_hihat1, compasso_hihat2, compasso_hihat3, compasso_hihat4,
				compasso_hihat5, compasso_hihat6, compasso_hihat7, compasso_hihat8]
	if current_instrument == 1:
		return [compasso_bumbo1, compasso_bumbo2, compasso_bumbo3, compasso_bumbo4, 
				compasso_bumbo5, compasso_bumbo6, compasso_bumbo7, compasso_bumbo8]


func current_audio_sem_solo():
	return "res://sounds/FASE2/100BPM/LOOPS/LOOP_SEM_" + instruments[current_instrument] + ".mp3"

func current_audio_mestra():
	return "res://sounds/FASE2/100BPM/SOLOS/" + instruments[current_instrument] + "_SOLO_INTEIRA.mp3"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hihat1.set_texture("res://img/mpc-button-green.png")
	$Bumbo1.set_texture("res://img/mpc-button-green.png")
	$Hihat1.hide()
	$Bumbo1.hide()
	hide_all_touch()
	$Compassos.set_music(music_according_to_phase())
	$Pontuacao.hide()
	$PreJogo.hide()

func hide_all_touch():
	$TouchHihat1.hide()
	$TouchBumbo1.hide()

func init_phase_buttons(btns):
	var i = 0
	for b in btns:
		i = i+1
		var obj = get_node(b)
		obj.set_stream("res://sounds/FASE2/100BPM/ONE_SHOT/" + instruments[current_instrument] + str(i) + ".mp3")
		obj.set_texture("res://img/mpc-button-green.png")
		obj.set_volume(40)
		obj.show()

func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(20)
	if current_instrument >= len(instruments):
		ended.emit()
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.set_instruction_node("AfroHouseHihat")
		$Tutorial.set_first_screen("res://img/tutorial1.jpeg", "voce vai tocar um sample digital!")
		$Tutorial.set_second_screen("res://img/tutorial2.jpeg", "dispare sons previamente gravados")
		$Tutorial.set_show_telas(true)
		$Hihat1.show()
		$Tutorial.start()
		$Compassos.set_music(music_according_to_phase())
		$Compassos.reset()

func set_instrument(i):
	current_instrument = i
	
func get_instrument():
	return current_instrument

func next():
	$Compassos.reset()
	start()
	show()
	
func reset():
	pontos = 0
	print("RESETOU NOTAS")
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
	if note == "A" || note == "a":
		if showed_bumbo1:
			$TouchBumbo1.texture = load("res://img/touch.png")
		else:
			$TouchBumbo1.texture = load("res://img/touch_double.png")
		showed_bumbo1 = !showed_bumbo1
		$TouchBumbo1.show()
		return
	if note == "h":
		if showed_hihat1:
			$TouchHihat1.texture = load("res://img/touch.png")
		else:
			$TouchHihat1.texture = load("res://img/touch_double.png")
		showed_hihat1 = !showed_hihat1
		$TouchHihat1.show()

func end():
	$AudioSemSolo.stop()
	$AudioMestra.stop()
	$Compassos.hide()
	$MPCBackground.hide()
	$Bumbo1.hide()
	$Hihat1.hide()
	hide()


func _on_tutorial_ended() -> void:
	if current_instrument > 3:
		compasso_ended = true
		ended.emit()
		return
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(40)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(20)
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()


func _on_hihat_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "h":
		update_pontos()


func _on_bumbo_1_pressed() -> void:
	var curr_note = $Compassos.get_current_note_name()
	if curr_note == "a" || curr_note == "A":
		update_pontos()

func _on_audio_sem_solo_finished() -> void:
	if !compasso_ended:
		$AudioSemSolo.play()

func instrument_time():
	if current_instrument == 0:
		return 0.1
	if current_instrument == 1:
		return 0.09

func _on_tutorial_countdown_show() -> void:
	hide_all_touch()
	var btns = []
	if current_instrument == 0:
		btns = ["Hihat1"]
		$Compassos.set_note_width(52)
		$Hihat1.show()
	if current_instrument == 1:
		btns = ["Bumbo1"]
		$Compassos.set_note_width(60)
		$Bumbo1.show()
	init_phase_buttons(btns)
	$Compassos.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_audio_mestra_finished() -> void:
	if !compasso_ended:
		$AudioSemSolo.play()


func _on_pre_jogo_countdown_show() -> void:
	$Hihat1.hide()
	$Bumbo1.hide()
	if current_instrument == 0:
		$Hihat1.show()
	if current_instrument == 1:
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
	$Hihat1.hide()
	$Bumbo1.hide()
	hide_all_touch()
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0%"
		if current_instrument == 0:
			$PreJogo.set_first_screen("res://img/pre-jogo-hihat1.png", "aperte o botao em destaque quando piscar")
			$PreJogo.set_second_screen("res://img/pre-jogo-hihat2.png", "bora tocar um pouco de hihat!")
		if current_instrument == 1:
			$PreJogo.set_first_screen("res://img/pre-jogo1.png", "aperte o botao em destaque quando piscar")
			$PreJogo.set_second_screen("res://img/pre-jogo2.png", "sua vez de tocar bumbo!")
		$PreJogo.show()
		$PreJogo.start()
		return
		
	if current_instrument == 0: 
		print("HIHAT ENDED", get_percent(), total_notas)
		hihat_ended.emit(get_percent())
	if current_instrument == 1:
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
		# Start bumbo		
		$Pontuacao.hide()
		$Tutorial.set_instruction_node("AfroHouseBumbo")
		$Tutorial.set_first_screen("res://img/tutorial-bumbo1.png", "agora vamos tocar bumbo!")
		$Tutorial.set_second_screen("res://img/tutorial-bumbo2.png", "veja como se faz")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
		$PreJogo.set_show_telas(true)
	if current_instrument >= len(instruments):
		end()
		ended.emit()


func _on_hihat_1_visibility_changed() -> void:
	print("HIHAT1 VISIBILITY CHANGED: is_visible_in_tree ", $Hihat1.is_visible_in_tree())
