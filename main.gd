extends Node
var replay_audio = true


func _ready():
	$AudioStreamPlayer.play()
	$End.hide()

func _on_hud_init():
	$HUD.hide()
	$Map.show()

func _on_timer_timeout() -> void:
	$Logos.hide()

func _on_mapa_finished() -> void:
	$Map.hide()
	$End.show()
	
	
func _on_audio_stream_player_finished() -> void:
	if replay_audio:
		$AudioStreamPlayer.stop()


func _on_map_clicked_taquaral() -> void:
	$AudioStreamPlayer.stop()
	replay_audio = false
