extends "Spaceship.gd"

func _process(_delta):
	move_direction.x = Input.get_action_strength("ui_right") \
					 - Input.get_action_strength("ui_left")
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot_laser(Vector2.UP, -60)
