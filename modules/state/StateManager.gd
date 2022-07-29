extends Node


export (NodePath) onready var initial_state = get_node(initial_state)
var current_state :BaseState


func change_state(new_state :BaseState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	print(current_state)


func init(character :Character) -> void:
	for child in get_children():
		child.character = character
	
	if initial_state:
		change_state(initial_state)


func physics_process(delta) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


func input(event :InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)