extends InputMoveState

export (NodePath) onready var fall_state = get_node(fall_state)


func input(event) -> BaseState:
	var new_state = .input(event)
	
	if event.is_action_released('move_left') or event.is_action_released('move_right'):
		new_state = idle_state
	
	return new_state


func physics_process(delta :float) -> BaseState:
	var new_state = .physics_process(delta)
	
	if not character.on_ground:
		new_state = fall_state
	
	if character.velocity.length() < 1:
		new_state = idle_state
	
	return new_state
