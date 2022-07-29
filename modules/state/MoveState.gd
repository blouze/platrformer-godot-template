extends BaseState
class_name MoveState

const COYOTE_TIME := 0.08


func physics_process(delta :float) -> BaseState:
	var new_state = .physics_process(delta)
	
	character.velocity += character.gravity
	character.velocity = character.move_and_slide_with_snap(character.velocity, character.snap, Vector2.UP)
	
	character.anim_sprite.flip_h = character.velocity.x < 0
	
	if character.is_on_floor():
		character.on_ground = character.is_on_floor()
	else: # COYOTE TIME
		get_tree().create_timer(COYOTE_TIME).connect("timeout", character, "set_on_ground", [false])
	
	return new_state
