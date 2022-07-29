extends ShakableCamera2D
class_name CustomCamera2D


export (NodePath) onready var viewport_container = get_node(viewport_container)
export (NodePath) onready var player = get_node(player)
export (Vector2) onready var camera_offset = Vector2(-0.125, -0.125)
export (float, 0, 10) var camera_lerp = 5

var game_size := Vector2(240, 135)
onready var window_scale := (OS.window_size / game_size)
onready var actual_cam_pos := global_position
onready var time_start = OS.get_ticks_msec()
onready var time_now = OS.get_ticks_msec()


func _process(delta):
	var cam_pos = player.global_position - player.velocity * camera_offset
	cam_pos.x = max(cam_pos.x, get_viewport_rect().size.x * 0.25)
	cam_pos.y -= 16	
	
#	actual_cam_pos = actual_cam_pos.linear_interpolate(cam_pos, delta * camera_lerp)
	actual_cam_pos.x = lerp(actual_cam_pos.x, cam_pos.x, delta * camera_lerp)
	actual_cam_pos.y = lerp(actual_cam_pos.y, cam_pos.y, delta * camera_lerp)
	
	var cam_offset = actual_cam_pos.round() - actual_cam_pos
	viewport_container.material.set_shader_param("cam_offset", cam_offset)
	
	global_position = actual_cam_pos.round()
	
#	zoom = Vector2.ONE * (1.0 + 0.15 * sin((OS.get_ticks_msec() - time_start) * 0.001))
