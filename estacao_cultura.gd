extends Node2D

signal finished
var palmas = 0
var aro = 0
var caixa = 0
var bumbo = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SambaTrapControls.hide()
	$PalmasControls.hide()
	$TextureRect.hide()
	
func _start() -> void:
	show()
	$TextureRect.show()
	$PalmasControls.show()
	$PalmasControls.start()


func _on_samba_trap_controls_aro_ended(pontos: Variant) -> void:
	aro = pontos

func get_pontos_aro():
	return aro

func _on_samba_trap_controls_bumbo_ended(pontos: Variant) -> void:
	bumbo = pontos

func get_pontos_bumbo():
	return bumbo

func _on_samba_trap_controls_caixa_ended(pontos: Variant) -> void:
	caixa = pontos

func get_pontos_caixa():
	return caixa

func _on_samba_trap_controls_ended() -> void:
	finished.emit()

func get_pontos_palmas():
	return palmas

func _on_palmas_controls_ended(pontos: Variant) -> void:
	palmas = pontos
	$PalmasControls.end()
	$PalmasControls.hide()
	$SambaTrapControls.start()
	$SambaTrapControls.show()
