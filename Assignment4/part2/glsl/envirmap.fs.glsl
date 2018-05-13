//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec2 Texcoord_V;

uniform samplerCube skybox;

void main() {
    //PRE-CALCS
    vec3 N = normalize(Normal_V);
    vec3 V = normalize(Position_V);
    
    //ENVIRONMENT MAPPING
    vec3 R = reflect(V, N);
    R = vec3(vec4(R, 0.0) * viewMatrix);
    vec4 env = textureCube(skybox, R);

	gl_FragColor = env;
}
