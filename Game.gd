tool
extends Node2D


export (bool) var is_level_open := false setget set_is_level_open
onready var player:Player = get_tree().get_nodes_in_group("player")[0]


func set_is_level_open(value):
	if is_inside_tree():
		$DoorIn.is_open = not value
		$DoorOut.is_open = value
	
	is_level_open = value


func _on_player_passed_door_in():
	set_is_level_open(true)


func _on_player_passed_door_out():
#	set_is_level_open(false)
	player.position = $DoorIn.position + (player.position - $DoorOut.position)
