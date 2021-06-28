extends Node2D

var is_player_dead := false

var score := 0

onready var audio_player = get_node("/root/Game/AudioPlayer")

func _unhandled_key_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_death():
	is_player_dead = true
	$ScoreText.text = "Score: " + str(score) + "\npress 'r' to restart"

func _on_enemy_death():
	score += 1
	
	if score % 10 == 0:
		audio_player.play_success_sound()
	
	if is_player_dead:
		$ScoreText.text = "Score: " + str(score) + "\npress 'r' to restart"
