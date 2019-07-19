#version 120                  // GLSL 1.20

varying vec3 v_color;         // per-fragment color (per-fragment input)
varying   vec3 v_position;
varying   vec3 v_normal;

void main()
{
	gl_FragColor = vec4(v_color, 1.0f);
}