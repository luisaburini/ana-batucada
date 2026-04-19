extends Node2D


signal ended(pontos)
signal hide_next

var already_played = false
var must_leave = false
var total_notas = 0
var audio_sem_solo = "res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/LOOPS_SEM_OS_SOLOS/LOOP_SEM_TRIANGULO.mp3"
var audio_mestra =  "res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/INSTRUMENTOS_SOLO/TRIANGULO.mp3"
var pontos = 0
var maozinha_solta = false
var tutorial_ended = false
# P - pausa de 1 tempo (Semínima)
# p - pausa de meio tempo (colcheia)

# R -  meio tempo (colcheia) do triangulo mao fechada
# S - 1 tempo (seminima) do triangulo mao fechada
# T - meio tempo (colcheia) do triangulo mao solta
var compasso1 = "RTRTRTRT"
var compasso2 = "RTRTRTRR"
var compasso3 = "RTRTRTRR"
var compasso4 = "RTRTRTS"
var compasso5 = "RTRTRTRT"
var compasso6 = "RTRTRTS"
var compasso7 = "RTRTRTRT"
var compasso8 = "RTRTRTS"

var current_sheet = [compasso1, compasso2, compasso3, compasso4,
					 compasso5, compasso6, compasso7, compasso8]

func current_music_sheet():
	return current_sheet

# Called when the node enters the scene tree for the first time.
func _ready():
	$Compasso.note_width = 42
	$BrilhoEmcima.hide()
	$BrilhoNaMao.hide()
	$Tutorial.set_first_screen("res://img/tutorial-triangulo1.png", "o som agora e do triangulo")
	$Tutorial.set_second_screen("res://img/tutorial2.jpeg", "sente so como a Mestra faz")
	$PreJogo.set_first_screen("res://img/pre-jogo-triangulo1.png", "bora tocar um pouco")
	$PreJogo.set_second_screen("res://img/pre-jogo-triangulo2.png", "clique no triangulo e na maozinha para tocar!")
	$Pontuacao.hide()
	$PreJogo.hide()


func _on_batedor_is_dragging(position: Variant) -> void:
	pass

func instrument_time():
	return 0.05


func set_audio_sem_solo(audio):
	audio_sem_solo = audio

func set_audio_mestra(audio):
	audio_mestra = audio

func set_music_sheet(music):
	current_sheet = music
	$Compasso.set_music(music)

func start():
	$Compasso.set_music(current_music_sheet())
	$AudioMestra.set_volume(30)
	$AudioMestra.load_audio(audio_mestra)
	$AudioSemSolo.set_volume(10)
	$AudioSemSolo.load_audio(audio_sem_solo)
	if !tutorial_ended:
		$Tutorial.start()
		$Compasso.reset()

	
func next():
	$Compasso.reset()
	start()
	show()
	
func reset():
	pontos = 0
	$Compasso.reset()
	start()
	show()


func update_pontos():
	if $Compasso.is_playing():
		pontos = pontos+1
		$Pontuacao.text = str(get_percent()) + "%"

func _on_compasso_ended():
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0"
		$BrilhoEmcima.hide()
		$BrilhoNaMao.hide()
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
	
func get_pontos():
	return pontos
	
func end():
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	hide()
	
func _on_tutorial_ended():
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()

func _on_maozinha_pressed() -> void:
	maozinha_solta = !maozinha_solta
	if maozinha_solta:
		$Maozinha.texture_normal = load("res://img/maozinha-solta.png")
	else:
		$Maozinha.texture_normal = load("res://img/maozinha.png")


func _on_tutorial_countdown_show() -> void:
	$Compasso.start_timer(instrument_time())
	$Pontuacao.hide()
	$AudioSemSolo.play()
	$AudioMestra.play()

func get_percent():
	if total_notas == 0:
		return 0
	return 100*pontos/total_notas


func _on_pre_jogo_countdown_show() -> void:
	$Compasso.start_timer(instrument_time())
	$AudioSemSolo.play()


func _on_pre_jogo_ended() -> void:
	$Pontuacao.show()
	$Compasso.start_timer(instrument_time())
	$AudioSemSolo.play()


func _on_compasso_seta_moved(current_note: Variant) -> void:
	already_played = false
	total_notas = total_notas+1
	$BrilhoEmcima.hide()
	$BrilhoNaMao.hide()
	if $Compasso.get_current_note_name() == "T":
		$BrilhoEmcima.show()
		update_pontos()
	if $Compasso.get_current_note_name() == "R" || $Compasso.get_current_note_name() == "S":
		$BrilhoNaMao.show()
		update_pontos()


func _on_triangulo_entered_triangulo() -> void:
	var triangulo_sample = "3"
	if $Compasso.get_current_note_name() == "T" && maozinha_solta:
		already_played = true
		update_pontos()
	
	if !maozinha_solta:
		triangulo_sample = "2"
		if $Compasso.get_current_note_name() == "R" || $Compasso.get_current_note_name() == "S":
			already_played = true
			update_pontos()
	
	$TrianguloLoader.set_volume(30)
	$TrianguloLoader.load_audio("res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/INSTRUMENTOS_ONE_SHOT/TRIANGULO/TRIANGULO"+triangulo_sample+".mp3")
	print()
	$TrianguloLoader.play()
