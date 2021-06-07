extends Node2D

var hit_sounds := []
var score_sound

func load_hit_sounds():
	hit_sounds.append(AudioStreamPlayer.new())
	hit_sounds[0].stream = load("res://Sounds/Hit1.ogg")
	hit_sounds.append(AudioStreamPlayer.new())
	hit_sounds[1].stream = load("res://Sounds/Hit2.ogg")
	
	self.add_child(hit_sounds[0])
	self.add_child(hit_sounds[1])

func load_score_sound():
	score_sound = AudioStreamPlayer.new()
	score_sound.stream = load("res://Sounds/ScoreSound.ogg")
	self.add_child(score_sound)

func play_hit_sound():
	hit_sounds[randi() % len(hit_sounds)].play()
	
func play_score_sound():
	score_sound.play()

func _ready():
	load_hit_sounds()
	load_score_sound()
	
	
