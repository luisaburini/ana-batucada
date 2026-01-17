extends Node2D

signal reset
signal next

func set_pontos(pontos):
	$Label.text = str(pontos)
	
func hide_next():
	$NextButton.hide()
	$Pontuacao.hide()
	$LoserLabel.show()

func _on_texture_button_pressed():
	reset.emit()
	hide()

func _on_next_button_pressed():
	next.emit()
	hide()
