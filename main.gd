extends Node
var replay_audio = true


func _ready():
	$ALongTimeAgoInAGalaxyFarFarAway.hide()
	$InitialStory.hide()
	$AudioStreamPlayer.set_volume_linear(0.5)
	$AudioStreamPlayer.play()
	$End.hide()

func _on_hud_init():
	$HUD.hide()
	$ALongTimeAgoInAGalaxyFarFarAway.show()
	$ALongTimeAgoInAGalaxyFarFarAway.start()

func _on_timer_timeout() -> void:
	$Logos.hide()

func _on_mapa_finished() -> void:
	$Map.must_blink_map(false)
	$Map.hide()
	$End.show()
	
	
func _on_audio_stream_player_finished() -> void:
	if replay_audio:
		$AudioStreamPlayer.play()


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
	


func _on_initial_story_ended() -> void:
	$InitialStory.hide()
	$Map.show()
	$Map.must_blink_map(true)


func _on_a_long_time_ago_in_a_galaxy_far_far_away_ended() -> void:
	$ALongTimeAgoInAGalaxyFarFarAway.hide()
	$InitialStory.show()
	$InitialStory.start()
