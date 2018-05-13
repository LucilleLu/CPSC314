// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 torusPosition;

void main() {
    vec3 newPosition = position + torusPosition;
    
    // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}
