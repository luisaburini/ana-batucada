extends Node
var replay_audio = true
var logos_state = 0
var ended = false
var language = ""


func _ready():
	language = "pt"
	$VBoxContainer/Portugues.hide()
	$VBoxContainer/Espanhol.hide()
	$VBoxContainer/Ingles.hide()
	$Logos1.show()
	$Timer.start(2)
	$ALongTimeAgoInAGalaxyFarFarAway.hide()
	$InitialStory.hide()
	$AudioStreamPlayer.set_volume_linear(0.5)
	$AudioStreamPlayer.play()
	$End.hide()

func _on_hud_init():
	$HUD.hide()
	$VBoxContainer/Espanhol.hide()
	$VBoxContainer/Ingles.hide()
	$VBoxContainer/Portugues.hide()
	$ALongTimeAgoInAGalaxyFarFarAway.start(language)
	$ALongTimeAgoInAGalaxyFarFarAway.show()

func _on_timer_timeout() -> void:
	$HUD.hide()
	$VBoxContainer/Espanhol.hide()
	$VBoxContainer/Ingles.hide()
	$VBoxContainer/Portugues.hide()
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
		$VBoxContainer/Espanhol.show()
		$VBoxContainer/Ingles.show()
		

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
	print("INITIAL STORY ENDED")
	$InitialStory.hide()
	$Map.change_language(language)
	$Map.show()
	$Map.must_blink_map(true)


func _on_a_long_time_ago_in_a_galaxy_far_far_away_ended() -> void:
	print("INITIAL STORY STARTED")
	$InitialStory.start(language)
	$InitialStory.show()
	$ALongTimeAgoInAGalaxyFarFarAway.hide()


func _on_reset_pressed() -> void:
	if ended:
		ended = false
		replay_audio = true
		logos_state = 0
		$Map.reset()
		_ready()


func _on_espanhol_pressed() -> void:
	$Reset.texture_normal = load("res://img/reset-es.png")
	$VBoxContainer/Ingles.show()
	$VBoxContainer/Portugues.show()
	$VBoxContainer/Espanhol.hide()
	language = "es"
	$HUD.change_language(language)


func _on_portugues_pressed() -> void:
	$Reset.texture_normal = load("res://img/reset-pt.png")
	$VBoxContainer/Ingles.show()
	$VBoxContainer/Portugues.hide()
	$VBoxContainer/Espanhol.show()
	language = "pt"
	$HUD.change_language(language)


func _on_ingles_pressed() -> void:
	$Reset.texture_normal = load("res://img/reset-en.png")
	$VBoxContainer/Ingles.hide()
	$VBoxContainer/Portugues.show()
	$VBoxContainer/Espanhol.show()
	language = "en"
	$HUD.change_language(language)
	
func get_language():
	return language
