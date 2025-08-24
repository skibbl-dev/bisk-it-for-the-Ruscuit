shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec3 base_color : source_color = vec3(0.973,0.922,0.804);
uniform vec3 shadow_color : source_color = vec3(0.882,0.761,0.627);
uniform vec2 shadow_offset = vec2(1,1);

void fragment() {
	vec3 c = textureLod(screen_texture, SCREEN_UV-(shadow_offset/vec2(640,480)), 0.0).rgb;
	vec3 d = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	
	COLOR.rgb = d.rgb;
	
	if( round(c*vec3(255,255,255)) != round(base_color*vec3(255,255,255))){
		if (!(round(d*vec3(255,255,255)) != round(base_color*vec3(255,255,255)))){
			COLOR.rgb = shadow_color;
		}
	}
}