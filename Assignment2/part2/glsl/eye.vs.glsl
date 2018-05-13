// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 EyePosition;
uniform vec3 lightPosition;

#define MAX_EYE_DEPTH 0.15

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

    
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    
    mat4 scaleMatrix = mat4(vec4(0.2, 0.0, 0.0, 0.0),
                            vec4(0.0, 0.2, 0.0, 0.0),
                            vec4(0.0, 0.0, 0.2, 0.0),
                            vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 translateMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                               vec4(0.0, 1.0, 0.0, 0.0),
                               vec4(0.0, 0.0, 1.0, 0.0),
                               vec4(EyePosition, 1.0));
    
//    mat4 xRotateMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
//                              vec4(0.0, cos(), sin(), 0.0),
//                              vec4(0.0, -sin(), cos(), 0.0),
//                              vec4(0.0, 0.0, 0.0, 1.0));
//
//    mat4 yRotateMatrix = mat4(vec4(cos(), 0.0, -sin(), 0.0),
//                              vec4(0.0, 1.0, 0.0, 0.0),
//                              vec4(sin(), 0.0, cos(), 0.0),
//                              vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 xRotateMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                              vec4(0.0, 0.0, -1.0, 0.0),
                              vec4(0.0, 1.0, 0.0, 0.0),
                              vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 yRotateMatrix = mat4(vec4(0.0, 0.0, -1.0, 0.0),
                              vec4(0.0 , 1.0, 0.0, 0.0),
                              vec4(1.0, 0.0, 0.0, 0.0),
                              vec4(0.0, 0.0, 0.0, 1.0));
    
    vec3 up = vec3(0.0, 1.0, 0.0);
    vec3 zVector = normalize(EyePosition-lightPosition);
    vec3 xVector = normalize(cross(up,zVector));
    vec3 yVector = (cross(xVector,zVector));
    
    mat4 lookAtMatrix = mat4(vec4(xVector,0.0),
                             vec4(yVector,0.0),
                             vec4(zVector,0.0),
                             vec4(EyePosition, 1.0));

  gl_Position = projectionMatrix * modelViewMatrix * translateMatrix * lookAtMatrix * scaleMatrix * xRotateMatrix * yRotateMatrix * vec4(position, 1.0);
    
    
}
