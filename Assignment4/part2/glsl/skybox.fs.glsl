// UNIFORMS
uniform samplerCube skybox;
varying vec3 Texcoord;

void main() {
    
    vec4 color = vec4(textureCube(skybox,Texcoord));
	gl_FragColor = color;
}
