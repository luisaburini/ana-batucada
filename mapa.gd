extends Node2D

signal finished

func _ready():
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaButton.hide()

func _on_taquaral_button_pressed() -> void:
	$Taquaral._start()
	$CerecampMogiana.hide()
	$EstacaoCultura.hide()
	$TaquaralButton.hide()
	$CerescampMogianaButton.show()


func _on_cerescamp_mogiana_button_pressed() -> void:
	$Taquaral.hide()
	$CerecampMogiana._start()
	$EstacaoCultura.hide()
	$CerescampMogianaButton.hide()
	$EstacaoCulturaButton.show()


func _on_estacao_cultura_button_pressed() -> void:
	$Taquaral.hide()
	$CerecampMogiana.hide()
	$EstacaoCultura._start()


func _on_estacao_cultura_finished() -> void:
	emit_signal("finished")


func _on_taquaral_finished() -> void:
	$Background.show()
	$CerescampMogianaButton.show()
	


func _on_cerecamp_mogiana_finished() -> void:
	$Background.show()
	$EstacaoCulturaButton.show()
