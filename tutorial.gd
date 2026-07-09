extends Node2D

signal countdown_show
signal ended

var bg_state = 0
var counter = 0
var show_telas = true
var first_screen = "res://img/tutorial1.png"
var first_text = "Clique no botão do sample para tocar
Primeiro eu toco, depois você me acompanha"

var instruction_node = ""

func set_instruction_node(i):
	instruction_node = i


# Called when the node enters the scene tree for the first time.
func _ready():
	bg_state = 0
	counter = 0
	show_telas = true
	first_screen = "res://img/tutorial1.png"
	first_text = "Clique no botão do sample para tocar
Primeiro eu toco, depois você me acompanha"

	instruction_node = ""

	$Metronomo.load_audio("res://sounds/FASE1/100BPM/METRONOMO.mp3")
	$Metronomo.set_volume(50)
	$ClickNext.load_audio("res://sounds/CLICK.mp3")
	$ClickNext.set_volume(15)
	$Next.hide()
	$Ambiente.load_audio("res://sounds/MUSICA_TUTORIAL_MESTRA.mp3")
	$Ambiente.set_volume(5)
	$FunkBumbo.hide()
	$FunkConga.hide()
	$FunkTriangulo.hide()
	
	$AfroHouseHihat.hide()
	$AfroHouseBumbo.hide()
	$AfroHouseGankogui.hide()
	
	$SambaTrapPalmas.hide()
	$SambaTrapAro.hide()
	$SambaTrapCaixa.hide()
	
	$ClickAudio.set_volume(30)
	$ClickAudio.load_audio("res://sounds/CLICK.mp3")

func set_first_screen(f, t):
	first_screen = f
	first_text = t
	

func start():
	counter = 0
	$Cena1.show()
	$Instructions.show()
	if show_telas:
		$Ambiente.play()
		$Cena1.texture = load(first_screen)
		$Instructions.text = first_text
		$Next.show()
		$Countdown.hide()
	else:
		$Cena1.hide()
		$Instructions.hide()
		$Ambiente.stop()
		$Next.hide()
		$Countdown.show()
		$Timer.start()
	show()

func set_show_telas(new_show_telas):
	show_telas = new_show_telas
	counter = 0
	$Countdown.text = "1"
	
	

func _on_timer_timeout():
	counter = counter+1
	if counter < 5:
		if counter == 1:
			print("METRONOMO PLAY")
			$Metronomo.play()
		$Countdown.text = str(counter)
		$Timer.start()
		return
	$Next.hide()
	$Metronomo.stop()
	countdown_show.emit()
	ended.emit()
	$Ambiente.stop()
	hide()
	$Timer.set_one_shot(true)
	$Timer.stop()
	$ClickAudio.stop()


func _on_timer_cena_1_timeout() -> void:
	print("TIMER CENA 2 TIMEOUT")
	$Cena1.hide()
	$Instructions.hide()
	var inode = get_node(instruction_node)
	if inode != null:
		inode.show()
		$ClickNext.show()
	else:
		$Next.hide()
		$ClickAudio.play()
		$Countdown.show()
		$Ambiente.stop()
		$Timer.start()



func _on_timer_cena_2_timeout() -> void:
	var inode = get_node(instruction_node)
	if inode != null:
		$Next.hide()
		inode.hide()
		$ClickAudio.play()
		$Countdown.show()
		$Ambiente.stop()
		$Timer.start()

func reset():
	bg_state = 0
	$Next.hide()
	

func _on_next_pressed() -> void:
	$ClickNext.play()
	bg_state = bg_state+1
	print("BG STATE: ", bg_state)
	if bg_state == 1:
		_on_timer_cena_1_timeout()
	if bg_state == 2:
		_on_timer_cena_2_timeout()
		$Next.hide()
