extends InputMoveState

export (NodePath) onready var hurt_state = get_node(hurt_state)
export (NodePath) onready var walk_state = get_node(walk_state)

export (float, 0.0, 0.5) var jump_buffer = 0.16
var jump_timer :SceneTreeTimer


func input(event :InputEvent) -> BaseState:
	if event.is_action_pressed('jump'):
		jump_timer = get_tree().create_timer(jump_buffer)
	
	return null


func physics_process(delta) -> BaseState:
	var new_state = .physics_process(delta)
	var hurt = false
	
	if character.on_ground:
		for i in character.get_slide_count():
			var collision = character.get_slide_collision(i)
			if collision.collider.is_in_group("nope"):
				hurt = true
				break
		
		if hurt:
			new_state = hurt_state
		else:
			if jump_timer and jump_timer.time_left > 0:
				jump_timer = null
				new_state = jump_state
			else:
				new_state = walk_state
	
	return new_state
