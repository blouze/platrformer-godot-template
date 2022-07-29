tool
class_name CustomLight
extends Node2D


export (Color) var color := Color.white
export (float, 0.0, 1.0, 0.01) var radius := 0.5
export (float, 0.0, 1.0, 0.01) var strength := 1.0
export (bool) var with_noise := false
export (float, 0.0, 0.5	, 0.01) var noise_strength := 0.0
export (float, 0.0, 0.5, 0.01) var noise_scale := 0.0

var noise = OpenSimplexNoise.new()
onready var start_time = OS.get_ticks_msec()
onready var now_time = OS.get_ticks_msec()
var noise_offset
var noise_amount

func _init():
	add_to_group("lights")
	randomize()
	noise_offset = rand_range(10, 100)
	update_noise()


func _physics_process(delta):
	now_time = OS.get_ticks_msec()
	if !Engine.editor_hint:
		update_noise()


func update_noise():
	if with_noise:
		noise_amount = get_noise()
	else:
		noise_amount = 0


func get_noise():
	var time_dif = now_time - start_time
	return (noise.get_noise_1d(time_dif * noise_scale + noise_offset) - 0.6) * noise_strength
