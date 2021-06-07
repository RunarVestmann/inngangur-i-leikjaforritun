extends KinematicBody2D

export var speed = 5

onready var start_speed = speed

var move_direction = Vector2.ONE

export(NodePath) var player_1_score_path
export(NodePath) var player_2_score_path

onready var player_1_score = get_node(player_1_score_path)
onready var player_2_score = get_node(player_2_score_path)

onready var audio_player = get_node("/root/AudioPlayer")

onready var screen_size = get_viewport().size

var last_paddle_touched = null

func _physics_process(delta):
	var collision = move_and_collide(move_direction.normalized() * speed)
	
	if collision:
		var collider = collision.collider
		if collider is Paddle:
			move_direction = collider.position.direction_to(self.position)
			if collider != last_paddle_touched:
				speed += 1
				last_paddle_touched = collider
		else:
			move_direction.y = -move_direction.y
			
		audio_player.play_hit_sound()

	if position.x < 0:
		player_2_score.increase_score()
		audio_player.play_score_sound()
		teleport_to_center()
	if position.x > screen_size.x:
		player_1_score.increase_score()
		audio_player.play_score_sound()
		teleport_to_center()

func teleport_to_center():
	speed = start_speed
	move_direction.x = -move_direction.x
	position = screen_size / 2
	if move_direction.x > 0:
		move_direction = Vector2.ONE
	else:
		move_direction = Vector2(-1, 1)
