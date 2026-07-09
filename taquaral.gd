extends Node2D

signal finished
var palmas = 0
var aro = 0
var caixa = 0
var bumbo = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ambiente.load_audio("res://sounds/FASE1/100BPM/AMBIENTE_TAQUARAL.mp3")
	$Ambiente.set_volume(1)
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
	$Comemoracao.load_audio("res://sounds/FANFARRA_DE_VITORIA.mp3")
	$Comemoracao.set_volume(30)
	$Comemoracao.play()
	$Background.show()
	$Timer.start(3)
	


func _on_samba_trap_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_samba_trap_controls_stop_ambient() -> void:
	$Ambiente.stop()


func _on_palmas_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_palmas_controls_stop_ambient() -> void:
	$Ambiente.stop()


func _on_timer_timeout() -> void:
	$Comemoracao.stop()
	$Background.hide()
	$Ambiente.stop()
	finished.emit()
	$Timer.stop()
	
func reset():
	palmas = 0
	aro = 0
	caixa = 0
	bumbo = 0
	$PalmasControls._ready()
	$SambaTrapControls._ready()
	_ready()
