extends Area2D

const CELL_SIZE = 16

export var time_btw_moves = 0.25
var time_passed = 0

onready var game = get_node("/root/Game")

onready var screen_size = get_viewport().size

var input_directions := []

var is_dead = false

onready var reset_text = get_node("/root/Game/ResetText")

var segment_scene = preload("res://Scenes/SnakeSegment.tscn")

var segments := [self]

var move_direction = Vector2.ZERO

func _process(_delta):
	if Input.is_action_pressed("up"):
		input_directions.append(Vector2.UP)
		
	if Input.is_action_pressed("down"):
		input_directions.append(Vector2.DOWN)
		
	if Input.is_action_pressed("left"):
		input_directions.append(Vector2.LEFT)
		
	if Input.is_action_pressed("right"):
		input_directions.append(Vector2.RIGHT)
		
func grow():
	var segment = segment_scene.instance()
	segment.position = Vector2(-100, -100)
	
	segments.append(segment)
	game.call_deferred("add_child", segment)
	
func move_segments():
	for i in range(len(segments)-1, 0, -1):
		segments[i].position = segments[i-1].position
	
	self.position += move_direction * CELL_SIZE
	
func screen_wrap():
	# Wrap x
	if self.position.x < 0:
		self.position.x = screen_size.x - CELL_SIZE
	elif self.position.x >= screen_size.x:
		self.position.x = 0
		
	# Wrap y
	if self.position.y < 0:
		self.position.y = screen_size.y - CELL_SIZE
	elif self.position.y >= screen_size.y:
		self.position.y = 0
	
func parse_inputs():
	if input_directions:
		move_direction = input_directions[-1]
		input_directions.clear()	
	
func _physics_process(delta):
	if time_passed >= time_btw_moves:
		if not self.is_dead:
			parse_inputs()
			move_segments()
			screen_wrap()
		time_passed = 0
	time_passed += delta
	
func get_occupied_positions():
	var occupied_positions := []
	for segment in segments:
		occupied_positions.append(segment.position)
	return occupied_positions

func _on_snake_head_collision(body):
	if body is Food:
		var occupied_positions = get_occupied_positions()
		body.respawn(occupied_positions)
		self.grow()
	else:
		self.is_dead = true
		reset_text.set_text("Your snake got to length "\
		+ str(len(segments)) + "\npress 'r' to restart")
