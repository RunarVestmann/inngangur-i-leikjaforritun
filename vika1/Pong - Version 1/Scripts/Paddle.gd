extends KinematicBody2D
class_name Paddle

var move_direction = Vector2.ZERO

export var is_player_one = true
export var speed = 5

func _process(_delta):
	var player_prefix
	
	if is_player_one:
		player_prefix = "player_1"
	else:
		player_prefix = "player_2"
	
	move_direction.y = Input.get_action_strength(player_prefix + "_down") \
					 - Input.get_action_strength(player_prefix + "_up")
				
func _physics_process(_delta):
	move_and_collide(move_direction * speed)
		
