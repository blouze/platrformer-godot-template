tool
extends StaticBody2D


export (bool) var is_open := true setget set_is_open
onready var player:Player = get_tree().get_nodes_in_group("player")[0]
signal player_passed_door()


func set_is_open(value):
	if is_inside_tree():
#		print("set_is_open: %s" % value)
		$Sprite.visible = not value
		$Sprite2.visible = value
		$CollisionShape2D.set_deferred("disabled", value)
	
	is_open = value


func _on_Area2D_body_exited(body):
	if body == player and (player.position - position).x > 0:
		emit_signal("player_passed_door")
