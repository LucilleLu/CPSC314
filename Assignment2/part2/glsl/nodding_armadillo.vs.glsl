// Shared variable passed to the fragment shader
varying vec3 color;
uniform float rotationArmX;
uniform float rotationArmY;
uniform float rotationHeadX;
uniform float rotationHeadY;

// Constant set via your javascript code
uniform vec3 lightPosition;

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);

    // Identifying the head
//    if (position.z < -0.33 && abs(position.x) < 0.46)
//        color = vec3(1.0, 0.0, 1.0);

	// Identifying the arm
//    if (position.z < 0.4 && position.y > 1.7 && position.x > 0.50)
//        color = vec3(1.0, 0.0, 1.0);
//    
//    if (position.z < 0.4 && position.y > 1.7 && position.x < -0.55)
//        color = vec3(1.0, 0.0, 1.0);
    
//    mat4 xRotateMatrixArm = mat4(vec4(1.0, 0.0, 0.0, 0.0),
//                              vec4(0.0, cos(), sin(), 0.0),
//                              vec4(0.0, -sin(), cos(), 0.0),
//                              vec4(0.0, 0.0, 0.0, 1.0));

    //Head
    mat4 xRotateMatrixHead = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                 vec4(0.0, cos(rotationHeadX), sin(rotationHeadX), 0.0),
                                 vec4(0.0, -sin(rotationHeadX), cos(rotationHeadX), 0.0),
                                 vec4(0.0, 0.0, 0.0, 1.0));
    mat4 yRotateMatrixHead = mat4(vec4(cos(rotationHeadY), 0.0, -sin(rotationHeadY), 0.0),
                                     vec4(0.0, 1.0, 0.0, 0.0),
                                     vec4(sin(rotationHeadY), 0.0, cos(rotationHeadY), 0.0),
                                     vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 translateMatrixHead = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                    vec4(0.0, 1.0, 0.0, 0.0),
                                    vec4(0.0, 0.0, 1.0, 0.0),
                                    vec4(0.0, 2.5, -0.1, 1.0));
    
    mat4 translateMatrixHeadInverse = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                           vec4(0.0, 1.0, 0.0, 0.0),
                                           vec4(0.0, 0.0, 1.0, 0.0),
                                           vec4(0.0, -2.5, 0.1, 1.0));

    //Arms
    mat4 xRotateMatrixArm = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                              vec4(0.0, cos(rotationArmX), sin(rotationArmX), 0.0),
                              vec4(0.0, -sin(rotationArmX), cos(rotationArmX), 0.0),
                              vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 yRotateMatrixArmLeft = mat4(vec4(cos(rotationArmY), 0.0, -sin(rotationArmY), 0.0),
                                      vec4(0.0, 1.0, 0.0, 0.0),
                                      vec4(sin(rotationArmY), 0.0, cos(rotationArmY), 0.0),
                                      vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 yRotateMatrixArmRight = mat4(vec4(cos(-rotationArmY), 0.0, -sin(-rotationArmY), 0.0),
                                       vec4(0.0, 1.0, 0.0, 0.0),
                                       vec4(sin(-rotationArmY), 0.0, cos(-rotationArmY), 0.0),
                                       vec4(0.0, 0.0, 0.0, 1.0));
    
    mat4 translateMatrixArmLeft = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                        vec4(0.0, 1.0, 0.0, 0.0),
                                        vec4(0.0, 0.0, 1.0, 0.0),
                                        vec4(0.5, 2.2, 0.1, 1.0));
   
    mat4 translateMatrixArmRight = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                        vec4(0.0, 1.0, 0.0, 0.0),
                                        vec4(0.0, 0.0, 1.0, 0.0),
                                        vec4(-0.5, 2.2, 0.1, 1.0));

    mat4 translateMatrixArmLeftInverse = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                               vec4(0.0, 1.0, 0.0, 0.0),
                                               vec4(0.0, 0.0, 1.0, 0.0),
                                               vec4(-0.5, -2.2, -0.1, 1.0));
    
    mat4 translateMatrixArmRightInverse = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                                                vec4(0.0, 1.0, 0.0, 0.0),
                                                vec4(0.0, 0.0, 1.0, 0.0),
                                                vec4(0.5, -2.2, -0.1, 1.0));


	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
    if (position.z < -0.33 && abs(position.x) < 0.46){
        gl_Position = projectionMatrix * modelViewMatrix * translateMatrixHead * xRotateMatrixHead * yRotateMatrixHead * translateMatrixHeadInverse * vec4(position, 1.0);
    } else if (position.z < 0.4 && position.y > 1.7 && position.x > 0.50) {
        gl_Position = projectionMatrix * modelViewMatrix * translateMatrixArmLeft * xRotateMatrixArm * yRotateMatrixArmLeft * translateMatrixArmLeftInverse * vec4(position, 1.0);
    } else if (position.z < 0.4 && position.y > 1.7 && position.x < -0.55) {
        gl_Position = projectionMatrix * modelViewMatrix * translateMatrixArmRight * xRotateMatrixArm * yRotateMatrixArmRight * translateMatrixArmRightInverse * vec4(position, 1.0);
    } else {
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    }

}
