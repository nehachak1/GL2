precision mediump float;

/* #TODO GL2.4
	Setup the varying values needed to compue the Phong shader:
	* surface normal
	* lighting vector: direction to light
	* view vector: direction to camera
*/
varying vec3 surface_normal;
varying vec3 view_vector;
varying vec3 light_vector;

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main()
{
	float material_ambient = 0.1;

	/*
	/* #TODO GL2.4: Apply the Blinn-Phong lighting model

	Implement the Blinn-Phong shading model by using the passed
	variables and write the resulting color to `color`.

	Make sure to normalize values which may have been affected by interpolation!
	*/
	// A small ambient term for the material:
    
    
    // 1) Normalize the vectors (they can get unnormalized after interpolation)
    vec3 n = normalize(surface_normal);
    vec3 v = normalize(view_vector);
    vec3 l = normalize(light_vector);

    // 2) Compute the half-vector for Blinn-Phong
    //    h = (l + v) / |l + v|
    vec3 h = normalize(l + v);

    // 3) Compute the Lambertian (diffuse) term: max(n . l, 0)
    float diff = max(dot(n, l), 0.0);

    // 4) Compute the specular term:
    //    Only add specular if the surface is facing the light (diff > 0)
    float spec = 0.0;
    if (diff > 0.0) {
        spec = pow(max(dot(n, h), 0.0), material_shininess);
    }

    // 5) Combine:
    //    Ambient: material_ambient * material_color
    //    Diffuse: diff * material_color * light_color
    //    Specular: spec * light_color (or spec * material_color * light_color if you want colored highlights)
    vec3 color = (light_color * material_ambient * material_color)
               + (light_color * material_color * (diff + spec));
			   
			   //+ (diff * material_color * light_color)
               //+ (spec * light_color);

	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}
