extends Node2D

var enemies_alive := 0
var spawn_count := 1

signal on_enemy_death

onready var enemy_scene = preload("res://Scenes/Enemy.tscn")

func _ready():
	for child in self.get_children():
		enemies_alive += 1
		child.connect("on_death", self, "on_enemy_death")
		
func on_enemy_death():
	enemies_alive -= 1
	emit_signal("on_enemy_death")
	if enemies_alive == 0:
		spawn_count += 1
		for i in range(spawn_count):
			spawn_enemy()
		enemies_alive = spawn_count

func spawn_enemy():
	var enemy = enemy_scene.instance()
	enemy.position = Vector2(rand_range(42, 984), 60)
	enemy.connect("on_death", self, "on_enemy_death")
	self.call_deferred("add_child", enemy)
