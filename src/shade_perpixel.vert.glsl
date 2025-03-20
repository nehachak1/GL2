// Vertex attributes, specified in the "attributes" entry of the pipeline
attribute vec3 vertex_position;
attribute vec3 vertex_normal;

// Per-vertex outputs passed on to the fragment shader

/* #TODO GL2.4
	Setup the varying values needed to compue the Phong shader:
	* surface normal
	* lighting vector: direction to light
	* view vector: direction to camera
*/
varying vec3 surface_normal;
varying vec3 view_vector;
varying vec3 light_vector;

// Global variables specified in "uniforms" entry of the pipeline
uniform mat4 mat_mvp;
uniform mat4 mat_model_view;
uniform mat3 mat_normals_to_view;

uniform vec3 light_position; //in camera space coordinates already


void main() {
	/** #TODO GL2.4:
	Setup all outgoing variables so that you can compute in the fragment shader
    the phong lighting. You will need to setup all the uniforms listed above, before you
    can start coding this shader.
	* surface normal
	* lighting vector: direction to light
	* view vector: direction to camera
    
	Hint: Compute the vertex position, normal and light_position in view space. 
    */
	// viewing vector (from camera to vertex in view coordinates), camera is at vec3(0, 0, 0) in cam coords
	/*view_vector = (vertex_position); // TODO vertex_position - cam pos but the latter is 0,0,0
	// direction to light source
	light_vector = (vertex_position - light_position); // TODO 
	// transform normal to camera coordinates
	surface_normal = (mat_normals_to_view * vertex_normal); // TODO apply normal transformation
	
	gl_Position = vec4(vertex_position, 1);*/
	
	// 1. Transform vertex position to view space
    vec3 vertex_pos_view = vec3(mat_model_view * vec4(vertex_position, 1.0));

    // 2. Compute the view vector (camera is at (0,0,0) in view space)
    view_vector = -vertex_pos_view;

    // 3. Compute the light vector (from vertex to light source)
    light_vector = (light_position - vertex_pos_view);

    // 4. Transform normal to camera space and normalize
    surface_normal = normalize(mat_normals_to_view * vertex_normal);

    // 5. Compute final position for rasterization
    gl_Position = mat_mvp * vec4(vertex_position, 1.0);
}