shader_type spatial;
render_mode skip_vertex_transform;

uniform sampler2D top_albedo : hint_albedo;
uniform sampler2D top_normalmap : hint_normal;
uniform sampler2D bottom_albedo : hint_albedo;
uniform sampler2D bottom_normalmap: hint_normal;
uniform vec4 color : hint_color;

varying vec3 local_normal;

void vertex() {
	local_normal = NORMAL;
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = (MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
	TANGENT = (MODELVIEW_MATRIX * vec4(TANGENT, 0.0)).xyz;
	BINORMAL = (MODELVIEW_MATRIX * vec4(BINORMAL, 0.0)).xyz;
}

void fragment() {
	float tf = step(0.9, dot(vec3(0.0, 1.0, 0.0), local_normal));
	float bf = step(0.9, dot(vec3(0.0, -1.0, 0.0), local_normal));
	
	ALBEDO = color.rgb;
	ALBEDO += texture(top_albedo, UV).rgb * color.rgb * tf - ALBEDO * tf;
	ALBEDO += texture(bottom_albedo, UV).rgb * color.rgb * bf - ALBEDO * bf;
	
	NORMALMAP = vec3(0.0, 1.0, 0.0);
	NORMALMAP += texture(top_normalmap, UV).rgb * tf - NORMALMAP * tf;
	NORMALMAP += texture(bottom_normalmap, UV).rgb * bf - NORMALMAP * bf;
	NORMALMAP_DEPTH = 1.0;
	
	METALLIC = 0.05;
	ROUGHNESS = 0.9;
	SPECULAR = 0.2;
}
