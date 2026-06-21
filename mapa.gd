extends Node2D

signal finished
signal clicked_taquaral
var show_mogiana = false
signal clicked_mogiana
var show_estacao = false
signal clicked_estacao_cultura
var show_end = false
var should_blink = false
var _show_blink = true

func _ready():
	$MogianaStory.hide()
	$EstacaoCulturaStory.hide()
	$Fanfarra.load_audio("res://sounds/FANFARRA_DE_VITORIA.mp3")
	$Fanfarra.set_volume(30)
	$ButtonClick.set_volume(30)
	$BlinkTimer.start(0.5)
	$Score.hide()
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$EstadioLabel.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaLabel.hide()
	$EstacaoCulturaButton.hide()

func _on_taquaral_button_pressed() -> void:
	$ButtonClick.load_audio("res://sounds/FASE3/100BPM/BOTAO_INICIAR3.mp3")
	$ButtonClick.play()
	should_blink = false
	_show_blink = false
	$BlinkTimer.stop()
	clicked_taquaral.emit()
	$Taquaral._start()
	$Campinas.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$TaquaralButton.hide()
	$TaquaralLabel.hide()
	$EstadioLabel.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaLabel.hide()
	$EstacaoCulturaButton.hide()


func _on_cerescamp_mogiana_button_pressed() -> void:
	$Campinas.hide()
	$ButtonClick.load_audio("res://sounds/FASE2/100BPM/BOTAO_INICIAR2.mp3")
	$ButtonClick.play()
	should_blink = false
	_show_blink = false
	$BlinkTimer.stop()
	clicked_mogiana.emit()
	$Taquaral.hide()
	$CerecampMogiana._start()
	$EstacaoCultura.hide()
	$EstadioLabel.hide()
	$CerescampMogianaButton.hide()
	


func _on_estacao_cultura_button_pressed() -> void:
	$Campinas.hide()
	$EstacaoCulturaLabel.hide()
	$ButtonClick.load_audio("res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/BOTAO_INICIAR1.mp3")
	$ButtonClick.play()
	should_blink = false
	_show_blink = false
	$BlinkTimer.stop()
	clicked_estacao_cultura.emit()
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura._start()
	


func _on_estacao_cultura_finished() -> void:
	show_estacao = false
	show_mogiana = false
	show_end = true
	$Score/Fase.text = "Estacao Cultura"
	var bumbo = $EstacaoCultura.get_pontos_bumbo()
	var conga = $EstacaoCultura.get_pontos_conga()
	var triangulo = $EstacaoCultura.get_pontos_triangulo()
	$Score.set_pontos_fase3(bumbo, conga, triangulo)
	$Fanfarra.play()
	$Score.show()
	$ScoreTimer.start(3)


func _on_taquaral_finished() -> void:
	show_estacao = false
	show_mogiana = true
	show_end = false
	$Background.texture = load("res://img/mapa-cerescamp.jpeg")
	_show_blink = true
	should_blink = true
	$BlinkTimer.start(0.5)
	$Taquaral.hide()
	var palmas = $Taquaral.get_pontos_palmas()
	var aro = $Taquaral.get_pontos_aro()
	var caixa = $Taquaral.get_pontos_caixa()
	$Score.set_pontos_fase1(palmas, aro, caixa)
	$Score/Fase.text = "Concha Acustica do Taquaral"
	$Fanfarra.play()
	$Score.show()
	$ScoreTimer.start(3)

func _on_cerecamp_mogiana_finished() -> void:
	show_estacao = true
	show_mogiana = false
	show_end = false
	$Background.texture = load("res://img/mapa-estacao-cultura.jpeg")
	$Background.show()
	_show_blink = true
	should_blink = true
	$BlinkTimer.start(0.5)
	$EstadioLabel.hide()
	$CerescampMogianaButton.hide()
	$CerecampMogiana.hide()
	$EstacaoCulturaButton.show()
	var hihat = $CerecampMogiana.get_pontos_hihat()
	print("$CerecampMogiana.get_pontos_hihat()", hihat)
	var bumbo = $CerecampMogiana.get_pontos_bumbo()
	print("$CerecampMogiana.get_pontos_bumbo()", bumbo)
	var gankogui = $CerecampMogiana.get_pontos_gankogui()
	print("$CerecampMogiana.get_pontos_gankogui()", gankogui)
	$Score/Fase.text = "Estadio Cerecamp Mogiana"
	$Score.set_pontos_fase2(hihat, bumbo, gankogui)
	$Fanfarra.play()
	$Score.show()
	$ScoreTimer.start(3)


func _on_score_timer_timeout() -> void:
	$Fanfarra.stop()
	$Score.hide()
	$Background.show()
	if show_estacao:
		$EstacaoCulturaStory.show()
		$EstacaoCulturaStory.start()
	if show_mogiana:
		$MogianaStory.show()
		$MogianaStory.start()
		
	if show_end:
		finished.emit()
	

func must_blink_map(command):
	should_blink = command


func _on_blink_timer_timeout() -> void:
	if !should_blink:
		return
	$BlinkTimer.start(0.5)
	if _show_blink:
		$Background.hide()
		$BackgroundBlink.show()
	else:
		$Background.show()
		$BackgroundBlink.hide()
	_show_blink = !_show_blink
		


func _on_mogiana_story_ended() -> void:
	$MogianaStory.hide()
	$Campinas.show()
	$EstadioLabel.show()
	$CerescampMogianaButton.show()


func _on_estacao_cultura_story_ended() -> void:
	$EstacaoCulturaStory.hide()
	$Campinas.show()
	$EstacaoCulturaLabel.show()
	$EstacaoCulturaButton.show()
