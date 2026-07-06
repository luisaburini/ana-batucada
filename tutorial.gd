extends Node2D

var bg_state = 0
var counter = 0
signal ended
signal countdown_show
var show_telas = true
var first_screen = "res://img/tutorial1.png"
var first_text = "vamos tocar um sample digital!\ndispare sons previamente gravados"
var second_screen = "res://img/tutorial2.jpeg"
var second_text = "da uma olhada como se faz"
var instruction_node = ""

func set_instruction_node(i):
	instruction_node = i
	#$Metronomo.set_volume(80)
	#if instruction_node == "SambaTrapPalmas" or instruction_node == "SambaTrapAro" or instruction_node == "SambaTrapPalmas":
		#$Metronomo.load_audio("res://sounds/FASE1/100BPM/METRONOMO.mp3")
	#if instruction_node == "AfroHouseHihat" or instruction_node == "AfroHouseBumbo" or instruction_node == "AfroHouseGankogui":
		#$Metronomo.load_audio("res://sounds/FASE2/100BPM/METRONOMO.mp3")
	#if instruction_node == "FunkBumbo" or instruction_node == "FunkConga" or instruction_node == "FunkTriangulo":
		#$Metronomo.load_audio("res://sounds/FASE3/100_BPM_CONGAS_E_TRIANGULO_REV/METRONOMO.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	$ClickAudio.set_volume(40)
	$ClickAudio.load_audio("res://sounds/FASE1/100_BPM_CONGAS_E_TRIANGULO_REV/CLICK.mp3")

func set_first_screen(f, t):
	first_screen = f
	first_text = t
	

func set_second_screen(s, t):
	second_screen = s
	second_text = t

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
		$Metronomo.play()
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
		$Countdown.text = str(counter)
		$Timer.start()
		return
	$Next.hide()
	countdown_show.emit()
	ended.emit()
	$Ambiente.stop()
	hide()
	$Timer.set_one_shot(true)
	$Timer.stop()
	$ClickAudio.stop()


func _on_timer_cena_1_timeout() -> void:
	print("TIMER CENA 1 TIMEOUT")
	$Cena1.texture = load(second_screen)
	$Instructions.text = second_text


func _on_timer_cena_2_timeout() -> void:
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

func _on_timer_cena_3_timeout() -> void:
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
	if bg_state == 3:
		_on_timer_cena_3_timeout()
		$Next.hide()
