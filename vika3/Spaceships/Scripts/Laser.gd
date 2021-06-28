extends Area2D

export var move_speed := 5.2

var move_direction := Vector2.UP

onready var audio_player = get_node("/root/Game/AudioPlayer")

func _ready():
	audio_player.play_laser_sound()

func set_color(new_color: Color):
	$Sprite.modulate = new_color

func _on_screen_exit():
	queue_free()

func _physics_process(_delta):
	self.position += move_direction * move_speed

func _on_laser_collision(_laser):
	audio_player.play_explosion_sound()
	queue_free()

func _on_ship_collision(ship):
	audio_player.play_explosion_sound()
	ship.explode()
	queue_free()
