extends Node2D

var counter = 0
var current_sound = ""
signal ended
signal countdown_show
var show_telas = true
var first_screen = "res://img/tutorial1.png"
var second_screen = "res://img/tutorial2.png"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_first_screen(f):
	first_screen = f

func set_second_screen(s):
	second_screen = s

func start():
	counter = 0
	$TimerCena1.set_one_shot(true)
	$TimerCena2.set_one_shot(true)
	$Cena1.show()
	if show_telas:
		$Cena1.texture = load(first_screen)
		$TimerCena1.start(3)
		$Countdown.hide()
	else:
		$Cena1.hide()
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
	countdown_show.emit()
	ended.emit()
	hide()
	$Timer.set_one_shot(true)
	$Timer.stop()


func _on_timer_cena_1_timeout() -> void:
	$Cena1.texture = load(second_screen)
	$TimerCena2.start(3)


func _on_timer_cena_2_timeout() -> void:
	$Cena1.hide()
	$Countdown.show()
	$Timer.start()
