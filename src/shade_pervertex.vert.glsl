// Vertex attributes, specified in the "attributes" entry of the pipeline
attribute vec3 vertex_position;
attribute vec3 vertex_normal;

// Per-vertex outputs passed on to the fragment shader

/* #TODO GL2.3
	Pass the values needed for per-pixel illumination by creating a varying vertex-to-fragment variable.
*/
varying vec3 frag_color;

// Global variables specified in "uniforms" entry of the pipeline
uniform mat4 mat_mvp;
uniform mat4 mat_model_view;
uniform mat3 mat_normals_to_view;

uniform vec3 light_position; // in camera space coordinates already

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main() {
	float material_ambient = 0.1;

	/** #TODO GL2.3 Gouraud lighting
	Compute the visible object color based on the Blinn-Phong formula.

	Hint: Compute the vertex position, normal and light_position in view space. 
	*/

	// Vertex_position is in object space - transformed to view space 
	// Lighting calculations are done in view space 
	// Position view - direction of vertex to camera
    vec3 position_view = (mat_model_view * vec4(vertex_position, 1.0)).xyz;
											// homogenous vector with w = 1.0

    // Transform normal (in object space) to view space
    vec3 normal_view = normalize(mat_normals_to_view * vertex_normal);

    // Compute light direction which is in view space
    vec3 light_direction = normalize(light_position - position_view);

    // Opposite of position_view
    vec3 view_direction = normalize(-position_view);

    // Compute lighting like with its 3 factors (ambient, diffuse, specular) 
    vec3 half_vector = normalize(light_direction + view_direction);

    vec3 ambient = material_ambient * light_color * material_color;

    float diffuse_contribution = max(dot(normal_view, light_direction), 0.0);
    vec3 diffuse = material_color * light_color * diffuse_contribution;

    float specular_factor = max(dot(normal_view, half_vector), 0.0);
    vec3 specular = material_color * light_color * pow(specular_factor, material_shininess);

    frag_color = ambient + diffuse + specular;
	gl_Position = mat_mvp * vec4(vertex_position, 1);
}

	