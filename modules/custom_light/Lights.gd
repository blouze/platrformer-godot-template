tool
extends Node2D


var image:Image = Image.new()
var texture:ImageTexture = ImageTexture.new()

var lights setget , get_lights
var num_lights = [] setget , get_num_lights

var light_level:float = 0.25


func get_lights():
	return get_tree().get_nodes_in_group("lights") if is_inside_tree() else []


func get_num_lights():
	return get_lights().size()


func _init():
	image.create(128, 2, false, Image.FORMAT_RGBAF)
	texture.create_from_image(image, 0)


func _physics_process(delta):
	var lights = get_tree().get_nodes_in_group("lights")
	
	image.lock()
	for i in lights.size():
		var light:CustomLight = lights[i]
		
		if light is CustomLight:
			var pos = light.get_global_transform_with_canvas().origin
			var vp_size = get_viewport_rect().size
			pos.x = clamp(pos.x, 0, vp_size.x) / vp_size.x
			pos.y = clamp(pos.y, 0, vp_size.y) / vp_size.y
			
			image.set_pixel(i, 0, Color(\
				pos.x, pos.y, \
				light.strength + light.noise_amount, light.radius))
			image.set_pixel(i, 1, light.color)
	
	image.unlock()
	texture.set_data(image)
