extends MoveState
class_name AIMoveState


export (NodePath) onready var jump_state = get_node(jump_state)
export (NodePath) onready var idle_state = get_node(idle_state)


func physics_process(delta :float) -> BaseState:
	var mvt = Vector2.ZERO
	
	mvt += Vector2.RIGHT
	
	character.velocity.x = mvt.normalized().x * character.h_mvt
	
	var new_state = .physics_process(delta)
	
	return new_state
