shader_type canvas_item;

instance uniform vec2 center_position = vec2(100.0, 100.0);
instance uniform vec4 effect_color: source_color = vec4(1, 0, 0, 1);
instance uniform float effect_radius = 100.0;
instance uniform bool is_outer = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 cpos = SCREEN_UV/SCREEN_PIXEL_SIZE-center_position;
	COLOR = effect_color;
	float e0 = 1.0;
	float e1 = 0.0;
	if (is_outer) {
		e0 = 0.0;
		e1 = 1.0;
	}
	float alpha = smoothstep(e0, e1, length(cpos)-effect_radius);
	COLOR.a = alpha;
}