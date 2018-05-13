varying vec3 Texcoord;

void main() {
    
    Texcoord = vec3(modelMatrix * vec4(position, 1.0)); //world frame
    
	gl_Position = (projectionMatrix * viewMatrix * vec4(Texcoord, 1.0)).xyww;
}
