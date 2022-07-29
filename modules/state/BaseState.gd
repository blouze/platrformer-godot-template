extends Node
class_name BaseState


var character :Character
export (String) var anim_name

var move_ref :FuncRef


func enter():
	character.anim_sprite.animation = anim_name


func exit():
	pass


func input(event :InputEvent) -> BaseState:
	return null


func process(delta :float) -> BaseState:
	return null


func physics_process(delta :float) -> BaseState:
	return null
