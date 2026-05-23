extends Node2D

signal finished
var hihat = 0
var bumbo = 0
var gankogui = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ambiente.load_audio("res://sounds/FASE2/100BPM/AMBIENTE_ESTADIO.mp3")
	$Ambiente.set_volume(20)
	$AfroHouseControls.hide()
	$TextureRect.hide()
	
func _start() -> void:
	show()
	$Ambiente.play()
	$GankoguiControls.hide()
	$AfroHouseControls.show()
	$AfroHouseControls.start()
	$TextureRect.show()


func _on_controls_ended() -> void:
	$AfroHouseControls.end()
	$GankoguiControls.show()
	$GankoguiControls.start()


func _on_score_next() -> void:
	$AfroHouseControls.hide()
	$AfroHouseControls.end()
	hide()
	emit_signal("finished")


func _on_score_reset() -> void:
	$AfroHouseControls.reset()
	
func get_pontos_hihat():
	return hihat

func get_pontos_bumbo():
	return bumbo

func get_pontos_gankogui():
	return gankogui

func _on_afro_house_controls_hihat_ended(pontos: Variant) -> void:
	hihat = pontos

func _on_afro_house_controls_bumbo_ended(pontos: Variant) -> void:
	bumbo = pontos

func _on_afro_house_controls_ended() -> void:
	$AfroHouseControls.end()
	$AfroHouseControls.hide()
	$GankoguiControls.start()
	$GankoguiControls.show()


func _on_gankogui_controls_ended(pontos: Variant) -> void:
	gankogui = pontos
	$Ambiente.stop()
	finished.emit()
