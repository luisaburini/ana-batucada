extends Node2D

var counter = 0
var max = 5
var current_sound = ""
signal ended
signal countdown_show
var show_telas = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	$TimerCena1.set_one_shot(true)
	$TimerCena2.set_one_shot(true)
	$TimerCena3.set_one_shot(true)
	$Metronomo.set_volume(50)
	$Metronomo.load_audio("res://sounds/FASE1_60BPM_METRONOMO.wav")
	if show_telas:
		$Cena1.show()
		$Cena2.hide()
		$Cena3.hide()
		$TimerCena1.start(3)
		$Countdown.hide()
	else:
		_on_timer_cena_3_timeout()
	show()

func set_show_telas(new_show_telas):
	show_telas = new_show_telas
	counter = 0
	$Countdown.text = "1"
	

func _on_timer_timeout():
	counter = counter+1
	if counter < max:
		$Countdown.text = str(counter)
		$Timer.start()
		return
	$Metronomo.stop()
	countdown_show.emit()
	ended.emit()
	hide()
	$Timer.set_one_shot(true)
	$Timer.stop()


func _on_timer_cena_1_timeout() -> void:
	$Cena1.hide()
	$Cena2.show()
	$TimerCena2.start(3)


func _on_timer_cena_2_timeout() -> void:
	$Cena2.hide()
	$Cena3.show()
	$TimerCena3.start(3)


func _on_timer_cena_3_timeout() -> void:
	$Cena3.hide()
	$Countdown.show()
	$Timer.start()
	print("Metronomo play")
	$Metronomo.play()
	
