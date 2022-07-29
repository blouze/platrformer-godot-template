extends InputMoveState


export (NodePath) onready var fall_state = get_node(fall_state)

export (int, 10, 50) var jump = 20


func enter():
	character.velocity -= character.gravity * jump
	character.on_ground = false
	character.add_child(Globals.puff_res.instance())
	.enter()


func input(event :InputEvent) -> BaseState:
	if event.is_action_released('jump'):
		character.velocity.y = 0
	
	return null


func physics_process(delta) -> BaseState:
	var new_state = .physics_process(delta)
	
	if character.velocity.dot(Vector2.DOWN) > 0:
		new_state = fall_state
	
	return new_state
