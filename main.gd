extends Node
var replay_audio = true
var logos_state = 0
var ended = false


func _ready():
	$Logos1.show()
	$Timer.start(2)
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
	
	$HUD.hide()
	logos_state = logos_state + 1
	if logos_state == 1:
		$Timer.start(2)
		$Logos1.hide()
		$Logos2.show()
	if logos_state == 2:
		$Logos2.hide()
		$Timer.set_one_shot(true)
		$Timer.stop()
		$HUD.show()
		

func _on_mapa_finished() -> void:
	$Map.must_blink_map(false)
	$Map.hide()
	ended = true
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


func _on_reset_pressed() -> void:
	if ended:
		ended = false
		replay_audio = true
		logos_state = 0
		$Map.reset()
		_ready()
