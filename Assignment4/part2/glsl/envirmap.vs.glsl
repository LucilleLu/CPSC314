//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec2 Texcoord_V;

void main() {

	Normal_V = vec3(modelViewMatrix * vec4(normal, 0.0));
    Position_V = vec3(modelViewMatrix * vec4(position, 1.0));

	Texcoord_V = uv;
   
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
