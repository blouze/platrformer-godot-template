extends InputMoveState

export (NodePath) onready var walk_state = get_node(walk_state)


func physics_process(delta) -> BaseState:
	var new_state = .physics_process(delta)
	
	if Input.is_action_pressed('move_right') or Input.is_action_pressed('move_left'):
		new_state = walk_state
		
	return new_state
