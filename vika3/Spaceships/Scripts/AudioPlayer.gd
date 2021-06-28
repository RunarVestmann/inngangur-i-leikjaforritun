extends Node2D

export var explosion_volume_db: float
export var laser_volume_db: float
export var success_volume_db: float

var explosion_sounds := []
var laser_sounds := []
var success_sound

func _ready():
	load_explosion_sounds()
	load_laser_sounds()
	load_success_sound()
	
func load_explosion_sounds():
	explosion_sounds.append(AudioStreamPlayer.new())
	explosion_sounds[0].stream = load("res://Sounds/Explosion1.ogg")
	explosion_sounds[0].set_volume_db(explosion_volume_db)
	self.call_deferred("add_child", explosion_sounds[0])
	
	explosion_sounds.append(AudioStreamPlayer.new())
	explosion_sounds[1].stream = load("res://Sounds/Explosion2.ogg")
	explosion_sounds[1].set_volume_db(explosion_volume_db)
	self.call_deferred("add_child", explosion_sounds[1])
	
func load_laser_sounds():
	laser_sounds.append(AudioStreamPlayer.new())
	laser_sounds[0].stream = load("res://Sounds/Laser1.ogg")
	laser_sounds[0].set_volume_db(laser_volume_db)
	self.call_deferred("add_child", laser_sounds[0])
	
	laser_sounds.append(AudioStreamPlayer.new())
	laser_sounds[1].stream = load("res://Sounds/Laser2.ogg")
	laser_sounds[1].set_volume_db(laser_volume_db)
	self.call_deferred("add_child", laser_sounds[1])
	
	laser_sounds.append(AudioStreamPlayer.new())
	laser_sounds[2].stream = load("res://Sounds/Laser3.ogg")
	laser_sounds[2].set_volume_db(laser_volume_db)
	self.call_deferred("add_child", laser_sounds[2])
	
func load_success_sound():
	success_sound = AudioStreamPlayer.new()
	success_sound.stream = load("res://Sounds/Success.ogg")
	success_sound.set_volume_db(success_volume_db)
	self.call_deferred("add_child", success_sound)
	
func play_explosion_sound():
	explosion_sounds[randi() % len(explosion_sounds)].play()
	
func play_laser_sound():
	laser_sounds[randi() % len(laser_sounds)].play()
	
func play_success_sound():
	success_sound.play()
