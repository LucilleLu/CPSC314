varying vec3 n1;
varying vec3 v1;

void main() {

	// TODO: PART 1B
    
    //diffuse
//    n = normalize(vec3(modelViewMatrix * vec4(normal, 0.0)));
    n1 = normalMatrix * normal;

    //specular
    v1 = vec3(modelViewMatrix * vec4(position, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
