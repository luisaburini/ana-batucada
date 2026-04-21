extends Node
var replay_audio = true


func _ready():
	$AudioStreamPlayer.set_volume_linear(0.5)
	$AudioStreamPlayer.play()
	$End.hide()

func _on_hud_init():
	$HUD.hide()
	$Map.show()
	$Map.must_blink_map(true)

func _on_timer_timeout() -> void:
	$Logos.hide()

func _on_mapa_finished() -> void:
	$Map.must_blink_map(false)
	$Map.hide()
	$End.show()
	
	
func _on_audio_stream_player_finished() -> void:
	if replay_audio:
		$AudioStreamPlayer.stop()


func _on_map_clicked_taquaral() -> void:
	stop_music()


func _on_map_clicked_mogiana() -> void:
	stop_music()


func _on_map_clicked_estacao_cultura() -> void:
	stop_music()

func stop_music():
	$Map.must_blink_map(false)
	$AudioStreamPlayer.stop()
	replay_audio = false
	
