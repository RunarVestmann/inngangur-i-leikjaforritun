extends KinematicBody2D

export var laser_color: Color
export var move_speed := 3.5
export var shot_interval: float = 1

var move_direction := Vector2.ZERO
var can_shoot := true
var shot_timer: Timer

signal on_death

onready var laser_scene = preload("res://Scenes/Laser.tscn")
onready var game = get_node("/root/Game")

func _ready():
	shot_timer = Timer.new()
	shot_timer.set_wait_time(shot_interval)
	shot_timer.connect("timeout", self, "allow_shooting")
	self.add_child(shot_timer)
	
func allow_shooting():
	can_shoot = true
	
func explode():
	emit_signal("on_death")
	queue_free()

func shoot_laser(direction: Vector2, offset: float):
	var laser = laser_scene.instance()
	laser.set_color(laser_color)
	laser.position = self.position + Vector2(0, offset)
	laser.move_direction = direction
	
	game.call_deferred("add_child", laser)
	
	can_shoot = false
	shot_timer.start()

func _physics_process(_delta):
	move_and_collide(move_direction * move_speed)
