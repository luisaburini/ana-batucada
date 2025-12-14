extends Node

func _ready():
	$End.hide()

func _on_hud_init():
	$HUD.hide()
	$Map.show()

func _on_timer_timeout() -> void:
	$Logos.hide()

func _on_mapa_finished() -> void:
	$Map.hide()
	$End.show()
