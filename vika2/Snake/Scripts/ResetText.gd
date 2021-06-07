extends Node2D

func set_text(new_text):
	$Label.text = new_text

func _input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
