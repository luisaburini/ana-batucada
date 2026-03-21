extends Node2D

signal ended
signal hide_next
var phases = ["BUMBO", "CONGAS"]
var btn_color = ["red", "blue", "green"]


var current_phase = 0
var pontos = 0
var was_pressed = false
var total_notas = 0
var compasso_ended = false

# P - pausa de 1 tempo (Semínima)
# p - pausa de meio tempo (colcheia)

# B - 1 tempo (semínima) do bumbo
# b - meio tempo (colcheia) do bumbo
var bumbo_compasso65 = "BPpbpb"
var bumbo_compasso66 = "BPbbP"
var bumbo_compasso67 = "BPpbpb"
var bumbo_compasso68 = "BPpbP"
var bumbo_compasso69 = "BPpbpb"
var bumbo_compasso70 = "BPbbP"
var bumbo_compasso71 = "BPpbpb"

# 1 - 1 tempo (seminima) de conga
# 2 - meio tempo (colcheia) de conga
# 3 - meio tempo (colcheia) mais meio de conga
# 4 - um quarto de tempo (semicolcheia) de conga
var conga_compasso1 = "41p1p4132"
var conga_compasso2 = "41p1414"
var conga_compasso3 = "41p1p4132"
var conga_compasso4 = "41o1414"
var conga_compasso5 = "41p1p4132"
var conga_compasso6 = "41p13241"
var conga_compasso7 = "41p1p132"
var conga_compasso8 = "41p13241"

func music_according_to_phase():
	if current_phase == 0:
		return  [bumbo_compasso65, bumbo_compasso66,	 bumbo_compasso67,	 bumbo_compasso68,
				 bumbo_compasso69, bumbo_compasso70, bumbo_compasso71]
	if current_phase == 1:
		return [conga_compasso1, conga_compasso2, conga_compasso3, conga_compasso4,
				conga_compasso5, conga_compasso6, conga_compasso7, conga_compasso8]

func current_audio_sem_solo():
	return "res://sounds/FASE1/LOOPS_SEM_OS_SOLOS/LOOP_SEM_" + phases[current_phase] + ".mp3"


func current_audio_mestra():
	return "res://sounds/FASE1/INSTRUMENTOS_SOLO/" + phases[current_phase] + "_SOLO.mp3"

var showed_bumbo1 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$conga1.hide()
	$conga2.hide()
	$conga3.hide()
	$conga4.hide()
	hide_all_touch()
	$Compasso.set_music(music_according_to_phase())
	if current_phase == 0:
		$TouchBumbo1.texture = load("res://img/touch.png")
		$TouchBumbo1.show()
		var btns = ["bumbo1"]
		init_phase_buttons(btns)
	$Pontuacao.hide()
	$PreJogo.hide()
	
	
	

func init_phase_buttons(btns):
	var i = 0
	for b in btns:
		i = i+1
		var obj = get_node(b)
		obj.set_stream("res://sounds/FASE1/INSTRUMENTOS_ONE_SHOT/" + phases[current_phase] + "/" + phases[current_phase] + str(i) + ".mp3")
		obj.set_texture("res://img/mpc-button-" + btn_color[current_phase] +".png")
		#obj.set_event_to_catch("pressed_b")
		#obj.set_event_to_catch("pressed_B")
		obj.set_volume(30)
		obj.show()
	
func start():
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioMestra.set_volume(30)
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$AudioSemSolo.set_volume(10)
	if current_phase >= len(phases):
		ended.emit()
		return
	was_pressed = false
	if !tutorial_ended:
		$Tutorial.start()
		$Compasso.set_music(music_according_to_phase())
		$Compasso.reset()

func set_phase(phase):
	current_phase = phase
	
func get_phase():
	return current_phase
	
func next():
	$Compasso.reset()
	start()
	show()
	
func reset():
	pontos = 0
	total_notas = 0
	was_pressed = false
	compasso_ended = false
	$Pontuacao.text = "0%"
	$Pontuacao.show()
	$AudioSemSolo.stop()
	$AudioMestra.load_audio(current_audio_mestra())
	$AudioSemSolo.load_audio(current_audio_sem_solo())
	$Compasso.reset()
	$Compasso.show()
	$MPCBackground.show()
	if current_phase == 0:
		$bumbo1.show()
		$TouchBumbo1.show()
	start()
	show()

func update_pontos():
	pontos = pontos+1
	if total_notas > 0:
		$Pontuacao.text = str(get_percent()) + "%"
	was_pressed = true

var must_leave = false

func _on_compasso_ended():
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0%"
		if current_phase == 0:
			$PreJogo.set_first_screen("res://img/pre-jogo1.png")
			$PreJogo.set_second_screen("res://img/pre-jogo2.png")
		if current_phase == 1:
			$PreJogo.set_first_screen("res://img/pre-jogo-conga1.png")
			$PreJogo.set_second_screen("res://img/pre-jogo-conga2.png")
		$PreJogo.show()
		$PreJogo.start()
		return
	current_phase = current_phase+1
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	tutorial_ended = false
	must_leave = false
	$Pontuacao.text = "0%"
	pontos = 0
	$Compasso.set_music(music_according_to_phase())
	$Compasso.reset()
	
	if current_phase == 1:
		# Start conga
		$Pontuacao.hide()
		$TouchBumbo1.hide()
		$Tutorial.set_first_screen("res://img/tutorial-conga1.png")
		$Tutorial.set_second_screen("res://img/tutorial-conga2.png")
		$Tutorial.set_show_telas(true)
		$Tutorial.start()
		$PreJogo.set_show_telas(true)
		$bumbo1.hide()
		$TouchConga4.show()
		var btns = ["conga1", "conga2", "conga3", "conga4"]
		init_phase_buttons(btns)
	if current_phase == 2:
		end()
		ended.emit()
		return
	
	
func get_pontos():
	return pontos

func get_percent():
	if total_notas == 0:
		return 0
	return 100*pontos/total_notas

func _on_compasso_seta_moved(note):
	update_touch(note)
	was_pressed = false
	total_notas = total_notas+1
	$Pontuacao.text = str(get_percent()) + "%"
	
func update_touch(note):
	hide_all_touch()
	if note == "B" || note == "b":
		if showed_bumbo1:
			$TouchBumbo1.texture = load("res://img/touch.png")
		else:
			$TouchBumbo1.texture = load("res://img/touch_double.png")
		showed_bumbo1 = !showed_bumbo1
		$TouchBumbo1.show()
		return
	if note == "1":
		$TouchConga1.show()
		return
	if note == "2":
		$TouchConga2.show()
		return
	if note == "3":
		$TouchConga3.show()
		return
	if note == "4":
		$TouchConga4.show()


func end():
	$AudioSemSolo.stop()
	$AudioMestra.stop()
	$Compasso.hide()
	$MPCBackground.hide()
	$bumbo1.hide()
	$conga1.hide()
	$conga2.hide()
	$conga3.hide()
	$conga4.hide()
	hide()
	
func hide_all_touch():
	$TouchBumbo1.hide()
	$TouchConga1.hide()
	$TouchConga2.hide()
	$TouchConga3.hide()
	$TouchConga4.hide()

var tutorial_ended = false
	
func _on_tutorial_ended():
	print("Bumbo Tutorial ended ", current_phase)
	if current_phase > 2:
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

func _on_conga1_pressed():
	var curr_note = $Compasso.get_current_note_name()
	if curr_note == "1":
		update_pontos()


		
func _on_mp_3_loader_finished():
	print("MPC CONTROLS AUDIO ENDED")
	if !compasso_ended:
		$AudioSemSolo.play()
		

func instrument_time():
	if current_phase == 0:
		print("instrument_time CURRENT_PHASE 0")
		return 0.15
	if current_phase == 1:
		print("instrument_time CURRENT_PHASE 1")
		return 0.14
	print("instrument_time CURRENT_PHASE", str(current_phase))
	return 0.2

func _on_tutorial_countdown_show() -> void:
	$Compasso.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()


func _on_bumbo_1_pressed() -> void:
	var curr_note = $Compasso.get_current_note_name()
	if curr_note == "B" || curr_note == "b":
		update_pontos()


func _on_conga_2_pressed() -> void:
	var curr_note = $Compasso.get_current_note_name()
	if curr_note == "2":
		update_pontos()


func _on_conga_3_pressed() -> void:
	var curr_note = $Compasso.get_current_note_name()
	if curr_note == "3":
		update_pontos()


func _on_conga_4_pressed() -> void:
	var curr_note = $Compasso.get_current_note_name()
	if curr_note == "4":
		update_pontos()


func _on_audio_sem_solo_finished() -> void:
	$AudioSemSolo.play()


func _on_pre_jogo_countdown_show() -> void:
	$Compasso.start_timer(instrument_time())
	$AudioSemSolo.play()



func _on_pre_jogo_ended() -> void:
	if current_phase >= len(phases):
		compasso_ended = true
		ended.emit()
		return
	$Pontuacao.show()
	$Compasso.start_timer(instrument_time())
	$AudioSemSolo.play()
	if current_phase == 1:
		$TouchConga1.hide()
		$TouchConga4.show()
	
