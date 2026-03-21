extends Node2D


signal ended
signal hide_next
var must_leave = false
var total_notas = 0
var audio_sem_solo = "res://sounds/FASE1/LOOPS_SEM_OS_SOLOS/LOOP_SEM_TRIANGULO.mp3"
var audio_mestra =  "res://sounds/FASE1/INSTRUMENTOS_SOLO/TRIANGULO_SOLO.mp3"
var pontos = 0
var maozinha_solta = false
var tutorial_ended = false

# P - pausa de 1 tempo (Semínima)
# p - pausa de meio tempo (colcheia)
# T - 1 tempo (semínima) do triangulo
# R - um quarto de tempo (semicolcheia) do triangulo
var compasso65 = "RTRTRTRTRTRTRTRT"
var compasso66 = "RRRRRRRRRRRRT"
var compasso67 = "RRRRRRRRRRRRRRRR"
var compasso68 = "RRRRRRRRRRRRT"
var compasso69 = "RRRRRRRRRRRRRRRR"
var compasso70 = "RRRRRRRRRRRRT"
var compasso71 = "RRRRRRRRRRRRRRRR"

var current_music_sheet = [compasso65, compasso66, compasso67, compasso68,
						   compasso69, compasso70, compasso71]

# Called when the node enters the scene tree for the first time.
func _ready():
	$BrilhoEmbaixo.hide()
	$BrilhoEmcima.hide()
	$Tutorial.set_first_screen("res://img/tutorial-triangulo1.png")
	$Tutorial.set_second_screen("res://img/tutorial2.png")
	$PreJogo.set_first_screen("res://img/pre-jogo-triangulo1.png")
	$PreJogo.set_second_screen("res://img/pre-jogo-triangulo2.png")
	$Pontuacao.hide()
	$PreJogo.hide()


func _on_batedor_is_dragging(position: Variant) -> void:
	pass
	#if position.x > 800 and position.x < 1200:
		#print(position)

func instrument_time():
	return 0.10


func set_audio_sem_solo(audio):
	audio_sem_solo = audio

func set_audio_mestra(audio):
	audio_mestra = audio

func set_music_sheet(music):
	current_music_sheet = music

func start():
	$Compasso.set_music(current_music_sheet)
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
	pontos = pontos+1
	$Pontuacao.text = str(get_percent()) + "%"
	print(pontos)
	
func _on_compasso_ended():
	if tutorial_ended && !must_leave:
		reset()
		must_leave = true
		pontos = 0
		$Pontuacao.text = "0"
		$PreJogo.show()
		$PreJogo.start()
		return
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	tutorial_ended = false
	must_leave = false
	$Pontuacao.text = "0"
	pontos = 0
	ended.emit()
	end()
	
func get_pontos():
	return pontos

func _on_compasso_seta_moved():
	total_notas = total_notas+1
	$Pontuacao.text = str(get_percent()) + "%"
	$BrilhoEmbaixo.hide()
	$BrilhoEmcima.hide()
	
	if $Compasso.get_current_note_name() == "T":
		print($Compasso.get_current_note_name())
		$BrilhoEmbaixo.show()
	elif $Compasso.get_current_note_name() == "R":
		print($Compasso.get_current_note_name())
		$BrilhoEmcima.show()
	else:
		print($Compasso.get_current_note_name())
	
func end():
	$AudioMestra.stop()
	$AudioSemSolo.stop()
	hide()
	
func _on_tutorial_ended():
	tutorial_ended = true
	$AudioMestra.play()
	$AudioSemSolo.play()


func _on_triangulo_entered_embaixo() -> void:
	print("entered embaixo")
	var note = "T"
	var triangulo_sample = "1"
	print("Compasso note " + $Compasso.get_current_note_name() + " " + note)
	if $Compasso.get_current_note_name() == note:
		update_pontos()
	$TrianguloLoader.set_volume(30)
	$TrianguloLoader.load_audio("res://sounds/FASE1/INSTRUMENTOS_ONE_SHOT/TRIANGULO/TRIANGULO"+triangulo_sample+".mp3")
	$TrianguloLoader.play()


func _on_triangulo_entered_emcima() -> void:
	print("entered emcima")
	var note = "R"
	var triangulo_sample = "2"
	print("Compasso note " + $Compasso.get_current_note_name() + " " + note)
	if $Compasso.get_current_note_name() == note:
		update_pontos()
	$TrianguloLoader.set_volume(30)
	$TrianguloLoader.load_audio("res://sounds/FASE1/INSTRUMENTOS_ONE_SHOT/TRIANGULO/TRIANGULO"+triangulo_sample+".mp3")
	$TrianguloLoader.play()


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
