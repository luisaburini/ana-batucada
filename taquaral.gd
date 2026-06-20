extends Node2D

signal finished
var palmas = 0
var aro = 0
var caixa = 0
var bumbo = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ambiente.load_audio("res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/AMBIENTE_CONCHA.mp3")
	$Ambiente.set_volume(25)
	$Background.hide()
	$SambaTrapControls.hide()
	$PalmasControls.hide()

func _start() -> void:
	show()
	$Background.show()
	$PalmasControls.show()
	$PalmasControls.start()
	
func get_pontos_aro():
	return aro

func get_pontos_palmas():
	return palmas

func get_pontos_caixa():
	return caixa

func _on_samba_trap_controls_aro_ended(pontos: Variant) -> void:
	aro = pontos

func _on_palmas_controls_ended(pontos: Variant) -> void:
	palmas = pontos
	$PalmasControls.end()
	$PalmasControls.hide()
	$SambaTrapControls.start()
	$SambaTrapControls.show()


func _on_samba_trap_controls_caixa_ended(pontos: Variant) -> void:
	caixa = pontos
	$SambaTrapControls.end()
	$SambaTrapControls.hide()
	$Ambiente.stop()
	finished.emit()


func _on_samba_trap_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_samba_trap_controls_stop_ambient() -> void:
	$Ambiente.stop()


func _on_palmas_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_palmas_controls_stop_ambient() -> void:
	$Ambiente.stop()
