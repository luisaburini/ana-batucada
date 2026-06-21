extends Node2D

var baloon = 0
signal ended()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ready baloon 0")
	baloon = 0
	$BaloonAna.hide()
	$BaloonMestra.hide()
	$BaloonMestra/Mestra1.hide()
	$BaloonMestra/Mestra2.hide()
	$BaloonMestra/Mestra3.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start():
	$Timer.autostart = false
	$Timer.one_shot = true
	baloon = 0
	print("start baloon 0")
	$Timer.start(1)


func _on_timer_timeout() -> void:
	$Timer.start(3)
	baloon = baloon+1
	print("timer timeout baloon ", baloon)
	if baloon == 1:
		$BaloonAna.hide()
		$BaloonMestra.show()
		$BaloonMestra/Mestra1.show()
		$BaloonMestra/Mestra2.hide()
		$BaloonMestra/Mestra3.hide()
		return
	if baloon == 2:
		$BaloonAna.show()
		$BaloonAna/Ana.show()
		$BaloonMestra.hide()
		$BaloonMestra/Mestra1.hide()
		$BaloonMestra/Mestra2.hide()
		$BaloonMestra/Mestra3.hide()
		return
	if baloon == 3:
		$BaloonAna.hide()
		$BaloonMestra.show()
		$BaloonMestra/Mestra1.hide()
		$BaloonMestra/Mestra2.show()
		$BaloonMestra/Mestra3.hide()
		return
	if baloon == 4:
		$BaloonAna.hide()
		$BaloonMestra.show()
		$BaloonMestra/Mestra1.hide()
		$BaloonMestra/Mestra2.hide()
		$BaloonMestra/Mestra3.show()
		return
	if baloon == 5:
		$Timer.stop()
		ended.emit()


func _on_touch_screen_button_pressed() -> void:
	$Timer.stop()
	ended.emit()
