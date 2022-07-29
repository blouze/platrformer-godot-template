shader_type canvas_item;

uniform vec4 flash_color :hint_color = vec4(vec3(0f), 1f);
uniform float intensity :hint_range(0f, 1f) = 0f;

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, flash_color.rgb, intensity);
	COLOR = color;
}
