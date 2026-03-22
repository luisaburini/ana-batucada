extends Node2D

signal finished
signal clicked_taquaral

func _ready():
	$Score.hide()
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaButton.hide()

func _on_taquaral_button_pressed() -> void:
	clicked_taquaral.emit()
	$Taquaral._start()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$TaquaralButton.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaButton.hide()


func _on_cerescamp_mogiana_button_pressed() -> void:
	$Taquaral.hide()
	$CerecampMogiana._start()
	$EstacaoCultura.hide()
	$CerescampMogianaButton.hide()
	


func _on_estacao_cultura_button_pressed() -> void:
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura._start()


func _on_estacao_cultura_finished() -> void:
	emit_signal("finished")


func _on_taquaral_finished() -> void:
	$Taquaral.hide()
	var bumbo = $Taquaral.get_pontos_bumbo()
	var conga = $Taquaral.get_pontos_conga()
	var triangulo = $Taquaral.get_pontos_triangulo()
	$Score.set_pontos(bumbo, conga, triangulo)
	$Score.show()
	$ScoreTimer.start(3)

func _on_cerecamp_mogiana_finished() -> void:
	$Background.show()
	$EstacaoCulturaButton.show()


func _on_score_timer_timeout() -> void:
	$Score.hide()
	$Background.show()
	$CerescampMogianaButton.show()
