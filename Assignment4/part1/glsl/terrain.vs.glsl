//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec4 PositionFromLight_V;
varying vec2 Texcoord_V;
varying vec4 ShadowCoord;

//UNIFORM VAR
// Inverse world matrix used to render the scene from the light POV
uniform mat4 lightViewMatrixUniform;
// Projection matrix used to render the scene from the light POV
uniform mat4 lightProjectMatrixUniform;

void main() {
	Normal_V = normalMatrix * normal;
	Position_V = vec3(modelViewMatrix * vec4(position, 1.0));
	Texcoord_V = uv;
    
    mat4 biasMatrix = mat4(0.5, 0.0, 0.0, 0.0,
                           0.0, 0.5, 0.0, 0.0,
                           0.0, 0.0, 0.5, 0.0,
                           0.5, 0.5, 0.5, 1.0);
    
    ShadowCoord = lightProjectMatrixUniform * lightViewMatrixUniform * modelMatrix * vec4(position, 1.0);
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
