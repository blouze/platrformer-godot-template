extends BaseState

export (NodePath) onready var fall_state = get_node(fall_state)

export (Vector2) var knockback = Vector2(-40, -20)


func enter():
	character.anim_player.play("Hurt")
	character.velocity = knockback * Vector2(character.velocity.sign().x, character.gravity.y)
	.enter()


func physics_process(delta) -> BaseState:
	var new_state = .physics_process(delta)
	
	character.velocity += character.gravity
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)
	
	if not character.anim_player.is_playing():
		new_state = fall_state
	
	return new_state
