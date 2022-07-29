tool
extends Node2D	
class_name Platform


export (Vector2) var offset := Vector2.ZERO setget set_offset
export (float, 0.0, 5.0) var duration := 2.0 setget set_duration
export (float, 0.0, 2.0) var idle_time := 1.0 setget set_idle_time

var follow = Vector2.ZERO
signal changed(platform)


func set_offset(value):
	offset = value
	emit_signal("changed", self)


func set_duration(value):
	duration = value
	emit_signal("changed", self)


func set_idle_time(value):
	idle_time = value
	emit_signal("changed", self)


func update_position():
	$PlatformBody.position = $PlatformBody.position.linear_interpolate(follow, 0.075)
