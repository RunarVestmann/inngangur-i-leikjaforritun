extends Node2D

onready var label = $Label

var current_score = 0

func increase_score():
	current_score += 1
	label.set_text(str(current_score))
	
