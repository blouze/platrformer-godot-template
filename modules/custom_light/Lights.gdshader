shader_type canvas_item;


uniform float intensity :hint_range(0f, 1f);

uniform int num_lights : hint_range(0, 7) = 0;
uniform sampler2D light_data;
uniform float burn : hint_range(0.0, 0.5, 0.01) = 0.1;

uniform float offset_modifier : hint_range(0.0, 8.0) = 1.2;
uniform float light_blend_modifier : hint_range(0.0, 1.0, 0.05) = 0.6;

uniform sampler2D dither_pattern : hint_white;
uniform float dither_res : hint_range(4.0, 16.0, 4.0) = 8.0;
uniform vec3 dither_offset = vec3(0.0);


float find_closest(float x, float y, float c0) {
	float limit = 1. - texture(dither_pattern, vec2(x, y) / dither_res).r;
	return c0 < limit ? 0.0 : 1.0;
}


void fragment() {
	vec2 resolution = 1f / SCREEN_PIXEL_SIZE;
	vec2 current_pixel = SCREEN_UV * resolution;
	
	vec4 color = vec4(1f);
	float m_value = 0.0;
	float sum = 0.0;
	
	for(int i = 0; i < num_lights; i++) {
//		float x = SCREEN_PIXEL_SIZE.x / distance(vec2(texel.x, UV.y), UV);
//		float y = SCREEN_PIXEL_SIZE.y / distance(vec2(UV.x, texel.y), UV);
//		if (x < 0f || y < 0f) continue;
		
		vec4 texel = texture(light_data, vec2(float(i) / 128., 0.));
		vec2 target_pixel = vec2(texel.x, 1f - texel.y) * resolution;
		float dist = distance(current_pixel, target_pixel);
		float radius = intensity * length(resolution);
		
		dist = min(dist / radius, 1.0);
		dist = max((dist * offset_modifier) - (offset_modifier - 1.), 0.);
		
		float value = 0.0;
		value = 1f - dist;
		
		value = clamp(value, 0f, 1f);
		sum += value;
		
		if (value > m_value) {
			m_value = value;
		}
	}
	
	m_value = mix(m_value, sum, light_blend_modifier);
	
	vec4 ambient_color = mix(vec4(vec3(0f), 0f), vec4(vec3(1f), 1f), m_value);
	vec4 lum = vec4(0.2126, 0.7152, 0.0722, 0);
	float grayscale = dot(ambient_color, lum);
	
	vec3 offset = floor(dither_offset);
	float x = mod(FRAGCOORD.x / 4f - offset.x, dither_res);
	float y = mod(FRAGCOORD.y / 4f + offset.y, dither_res);
	float grey = find_closest(x, y, smoothstep(burn, 1. - burn, grayscale));
	
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * vec4(vec3(grey), 1.);
}
