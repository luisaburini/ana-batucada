extends Node2D

signal ended
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	var btns = ["A", "B", "C", "D"]
	for b in btns:
		var obj = get_node(b)
		obj.set_text(b)
		obj.set_stream("res://sounds/" + b + ".mp3")
		obj.set_texture("res://img/"+b+".png")
	
func start():
	$Compasso.start_timer()

var pontos = 0

func _on_a_pressed():
	if $Compasso.get_current_note() == "A":
		pontos = pontos+1
		$Label.text = str(pontos)


func _on_b_pressed():
	if $Compasso.get_current_note() == "B":
		pontos = pontos+1
		$Label.text = str(pontos)


func _on_c_pressed():
	if $Compasso.get_current_note() == "C":
		pontos = pontos+1
		$Label.text = str(pontos)


func _on_d_pressed():
	if $Compasso.get_current_note() == "D":
		pontos = pontos+1
		$Label.text = str(pontos)


func _on_compasso_ended():
	ended.emit()
	
func get_pontos():
	return pontos
