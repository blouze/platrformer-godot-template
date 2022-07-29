tool
extends ColorRect


export (NodePath) var viewport_container
export (ViewportTexture) var viewport_texture setget set_viewport_texture
export (NodePath) var camera

var image:Image = Image.new()
var texture:ImageTexture = ImageTexture.new()

enum DITHER { DOT, FOUR, EIGHT, SIXTEEN }
export (DITHER) var dither_size := DITHER.EIGHT setget set_dither_size

var dither_textures = {
	DITHER.DOT: "res://assets/img/dithering/DotDither4x4.png",
	DITHER.FOUR: "res://assets/img/dithering/BayerDither4x4.png",
	DITHER.EIGHT: "res://assets/img/dithering/BayerDither8x8.png",
	DITHER.SIXTEEN: "res://assets/img/dithering/BayerDither16x16.png"
}
var dither_sizes = {
	DITHER.DOT: 4,
	DITHER.FOUR: 4,
	DITHER.EIGHT: 8,
	DITHER.SIXTEEN: 16
}

onready var dither_texture:StreamTexture = StreamTexture.new()


func set_viewport_texture(value):
	viewport_texture = value
	material.set_shader_param("mask", viewport_texture)


func set_dither_size(value):
	dither_size = value
	if !dither_texture:
		dither_texture = StreamTexture.new()
	dither_texture = load(dither_textures[dither_size])
	
	material.set_shader_param("dither_res", dither_sizes[dither_size])
	material.set_shader_param("dither_pattern", dither_texture)


func _init():
	image.create(128, 2, false, Image.FORMAT_RGBAF)
	texture.create_from_image(image, 0)


func _ready():
	set_dither_size(dither_size)
	material.set_shader_param("rect_size", get_viewport().size)


func _process(delta):
	var lights = get_tree().get_nodes_in_group("lights")
	
	image.lock()
	for i in lights.size():
		var light:CustomLight = lights[i]
		
		if light is CustomLight:
			var pos = light.get_global_transform_with_canvas().origin \
				* get_node(viewport_container).rect_scale / get_viewport_rect().size
			
			image.set_pixel(i, 0, Color(\
				pos.x, pos.y, \
				light.strength + light.noise_amount, light.radius))
			image.set_pixel(i, 1, light.color)
	
	image.unlock()
	texture.set_data(image)
	
	material.set_shader_param("num_lights", lights.size())
	material.set_shader_param("light_data", texture)
	
#	var dither_offset = fmod((get_node(camera) as Camera2D).global_position.x, 4)
#	print(dither_offset)
#	material.set_shader_param("dither_offset", dither_offset)
