extends KinematicBody2D

export var speed = 5

var move_direction = Vector2.ONE

export(NodePath) var player_1_score_path
export(NodePath) var player_2_score_path

onready var player_1_score = get_node(player_1_score_path)
onready var player_2_score = get_node(player_2_score_path)

func _physics_process(delta):
	var collision = move_and_collide(move_direction.normalized() * speed)
	
	if collision:
		if collision.collider is Paddle:
			move_direction.x = -move_direction.x
		move_direction.y = -move_direction.y

	if position.x < 0:
		player_2_score.increase_score()
		teleport_to_center()
	if position.x > 1024:
		player_1_score.increase_score()
		teleport_to_center()

func teleport_to_center():
	move_direction.x = -move_direction.x
	position = Vector2(512, 299)
