extends Node2D

signal finished
var current_phase = 0
var bumbo_percent = 0
var conga_percent = 0
var triangulo_percent = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.hide()
	$FunkMPCControls.hide()
	$FunkTrianguloControls.hide()

func _start() -> void:
	show()
	$Background.show()
	$FunkMPCControls.show()
	$FunkMPCControls.start()


func _on_controls_ended() -> void:
	$FunkMPCControls.end()
	$FunkMPCControls.hide()
	$FunkTrianguloControls.start()
	$FunkTrianguloControls.show()
	


func _on_funk_triangulo_controls_ended(pontos: Variant) -> void:
	print("Ended triangulo" + str(pontos))
	triangulo_percent = pontos
	finished.emit()


func _on_funk_mpc_controls_bumbo_ended(pontos: Variant) -> void:
	print("Ended bumbo" + str(pontos))
	bumbo_percent = pontos


func _on_funk_mpc_controls_conga_ended(pontos: Variant) -> void:
	print("Ended conga" + str(pontos))
	conga_percent = pontos
	
func get_pontos_bumbo():
	return bumbo_percent
	
func get_pontos_conga():
	return conga_percent

func get_pontos_triangulo():
	return triangulo_percent
