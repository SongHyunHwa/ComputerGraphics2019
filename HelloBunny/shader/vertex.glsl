#version 120                  // GLSL 1.20

uniform mat4 u_PVM;           // Proj * View * Model
uniform mat4 u_M; //make uniform 변수 Model
uniform mat4 u_VM; //View * Model

attribute vec3 a_position;    // per-vertex position (per-vertex input)
attribute vec3 a_normal;       // per-vertex color (per-vertex input)

varying vec3 v_color;       // per-vertex color (per-vertex output)
varying vec3 v_position;
varying vec3 v_normal;

uniform vec3 u_cam_position;
uniform vec3 u_light_position; //
uniform vec3 u_light_diffuse; //Ld
uniform vec3 u_material_diffuse; //스카파 d

uniform vec3 u_material_ambient;
uniform vec3 u_light_ambient;

uniform vec3 u_material_specular;
uniform vec3 u_light_specular;

vec3 calc_color()
{
  vec3 color = vec3(0);
  vec3 p_wc = (u_M * vec4(a_position,1)).xyz; //x_world = M* x_ obj;
  vec3 n_wc = (u_M * vec4(a_normal,0)).xyz; //n_world = no_obj*M

  vec3 l_wc = normalize(u_light_position - p_wc);
  vec3 r_wc = normalize(2 * dot(l_wc, n_wc) * n_wc - l_wc);
	
  vec3 v_wc = normalize(u_cam_position - p_wc);
  
  float ndotl = max(dot(n_wc, l_wc),0); //양수만
  color += (ndotl * u_light_diffuse * u_material_diffuse); //u_light_diffuse
  
  color += u_light_ambient * u_material_ambient;

  float rdotv = max(dot(r_wc,v_wc),0);
  color += (pow(rdotv, 20.f) * u_light_specular * u_material_specular);
  
  return color;
}

void main()
{
  gl_Position = u_PVM * vec4(a_position, 1.0f);
  v_color =  calc_color(); //함수로부터 계산해서 받는다
 }
