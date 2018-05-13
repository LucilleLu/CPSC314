uniform vec3 lightPosition;
uniform vec3 EyePosition;


void main() {
    
    float scale = length(lightPosition - EyePosition)/2.0;
    
    mat4 scaleMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                            vec4(0.0, scale, 0.0, 0.0),
                            vec4(0.0, 0.0, 1.0, 0.0),
                            vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 translateMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                vec4(0.0, 1.0, 0.0, 0.0),
                                vec4(0.0, 0.0, 1.0, 0.0),
                                vec4(EyePosition/2.0, 1.0));
    
    mat4 xRotateMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                              vec4(0.0, 0.0, -1.0, 0.0),
                              vec4(0.0, 1.0, 0.0, 0.0),
                              vec4(0.0, 0.0, 0.0, 1.0));

    vec3 up = vec3(0.0, 1.0, 0.0);
    vec3 zVector = normalize(EyePosition-lightPosition);
    vec3 xVector = normalize(cross(up,zVector));
    vec3 yVector = (cross(xVector,zVector));

    mat4 lookAtMatrix = mat4(vec4(xVector,0.0),
                             vec4(yVector,0.0),
                             vec4(zVector,0.0),
                             vec4(EyePosition/2.0, 1.0));
    
    gl_Position = projectionMatrix * modelViewMatrix * translateMatrix * lookAtMatrix * xRotateMatrix * scaleMatrix * vec4(position, 1.0);
}
