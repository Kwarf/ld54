shader_type spatial;

uniform sampler2D albedo : source_color;
uniform int color_index : hint_range(0, 32);

void fragment() {
	ALBEDO = texture(albedo, UV + vec2(1.0 / 32.0 * float(color_index))).rgb;
}
