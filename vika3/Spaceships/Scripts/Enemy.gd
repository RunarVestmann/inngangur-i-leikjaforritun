extends "Spaceship.gd"

const HORIZONTAL_DIRECTIONS := [-1, 1]

export var min_move_speed := 0.5
export var max_move_speed := 2.2

export var min_shot_interval := 1.5
export var max_shot_interval := 4.5

onready var move_timer = $MoveTimer

func allow_shooting():
	shoot_laser(Vector2.DOWN, 60)
	shot_timer.start()

func _ready():
	move_speed = rand_range(min_move_speed, max_move_speed)
	shot_timer.set_wait_time(rand_range(min_shot_interval, max_shot_interval))
	move_direction.x = HORIZONTAL_DIRECTIONS[randi() % len(HORIZONTAL_DIRECTIONS)]
	shot_timer.start()
	move_timer.start()
	$AnimationPlayer.play("FadeIn")

func _on_timeout():
	move_direction.x = HORIZONTAL_DIRECTIONS[randi() % len(HORIZONTAL_DIRECTIONS)]
	move_timer.start()
