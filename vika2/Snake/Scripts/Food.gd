extends StaticBody2D
class_name Food

const CELL_SIZE = 16
onready var screen_size = get_viewport().size

func _ready():
	randomize()
	respawn([])
	
func get_free_positions(occupied_positions):
	var free_positions := []
	
	for x in range(0, screen_size.x, CELL_SIZE):
		for y in range(0, screen_size.y, CELL_SIZE):
			var cell_position = Vector2(x, y)
			if not cell_position in occupied_positions:
				free_positions.append(cell_position)
	return free_positions

func respawn(occupied_positions):
	var free_positions = get_free_positions(occupied_positions)
	if free_positions:
		self.position = free_positions[randi() % len(free_positions)]
	else:
		queue_free()
