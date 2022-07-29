tool
extends StaticBody2D	
class_name ConveyorBelt


const LEFT = Vector2.LEFT
const RIGHT = Vector2.RIGHT
enum DIRECTION { LEFT, RIGHT }
export (DIRECTION) var direction := DIRECTION.RIGHT

const MAX_LENGTH = 10
export (int, 1, 10) var length := 3 setget set_length


func set_length(value):
	length = value
	
	if is_inside_tree():
		for i in range(0, MAX_LENGTH):
			$TileMap.set_cellv(Vector2(i, 0), 3 if i < length else -1)
		
		$TileMap.update_bitmask_region(Vector2.ZERO, Vector2(MAX_LENGTH, 0))


func _ready():
	set_length(length)
#	constant_linear_velocity.x = speed
