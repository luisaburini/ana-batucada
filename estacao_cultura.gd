extends Node2D

signal finished
var current_phase = 0
var bumbo_percent = 0
var conga_percent = 0
var triangulo_percent = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ambiente.load_audio("res://sounds/FASE3/100BPM/AMBIENTE_ESTACAO.mp3")
	$Ambiente.set_volume(25)
	$TrianguloControls.hide()
	$FunkMPCControls.hide()
	$TextureRect.hide()
	
func _start() -> void:
	show()
	$TextureRect.show()
	$FunkMPCControls.show()
	print("ESTACAO CULTURA START")
	$FunkMPCControls.start()

func _on_triangulo_controls_ended(pontos: Variant) -> void:
	print("Ended triangulo" + str(pontos))
	triangulo_percent = pontos
	$Comemoracao.load_audio("res://sounds/FANFARRA_DE_VITORIA.mp3")
	$Comemoracao.set_volume(30)
	$Comemoracao.play()
	$Timer.start(3)

func get_pontos_bumbo():
	return bumbo_percent
	
func get_pontos_conga():
	return conga_percent

func get_pontos_triangulo():
	return triangulo_percent


func _on_funk_mpc_controls_bumbo_ended(pontos: Variant) -> void:
	print("Ended bumbo" + str(pontos))
	bumbo_percent = pontos
	
	
func _on_funk_mpc_controls_conga_ended(pontos: Variant) -> void:
	print("Ended conga" + str(pontos))
	conga_percent = pontos
	


func _on_funk_mpc_controls_ended() -> void:
	$FunkMPCControls.end()
	$FunkMPCControls.hide()
	$TrianguloControls.start()
	$TrianguloControls.show()


func _on_funk_mpc_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_funk_mpc_controls_stop_ambient() -> void:
	$Ambiente.stop()


func _on_triangulo_controls_play_ambient() -> void:
	$Ambiente.play()


func _on_triangulo_controls_stop_ambient() -> void:
	$Ambiente.stop()


func _on_timer_timeout() -> void:
	$Comemoracao.stop()
	$FunkMPCControls.hide()
	$TrianguloControls.hide()
	$TextureRect.show()
	
	$Timer.set_one_shot(true)
	$Timer.stop()
	
	$Ambiente.stop()
	finished.emit()
	
func reset():
	current_phase = 0
	bumbo_percent = 0
	conga_percent = 0
	triangulo_percent = 0
	_ready()
	$FunkMPCControls._ready()
	$TrianguloControls._ready()
