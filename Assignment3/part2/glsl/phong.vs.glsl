varying vec3 n1;
varying vec3 v1;

void main() {
	// TODO: PART 1A
    
    //diffuse
    n1 = normalMatrix * normal;
//    n = normalize(vec3(modelViewMatrix * vec4(normal, 0.0)));
    
    //specular
    v1 = vec3(modelViewMatrix * vec4(position, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
