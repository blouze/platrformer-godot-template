extends MoveState
class_name InputMoveState


export (NodePath) onready var jump_state = get_node(jump_state)
export (NodePath) onready var idle_state = get_node(idle_state)


func input(event) -> BaseState:
	var new_state = .input(event)
	
	if event.is_action_pressed('jump'):
		new_state = jump_state
	
	return new_state


func physics_process(delta :float) -> BaseState:
	var mvt = Vector2.ZERO
	
	if Input.is_action_pressed('move_right'):
		mvt += Vector2.RIGHT
	if Input.is_action_pressed('move_left'):
		mvt += Vector2.LEFT
	
	character.velocity.x = mvt.normalized().x * character.h_mvt
	
	var new_state = .physics_process(delta)
	
	return new_state
