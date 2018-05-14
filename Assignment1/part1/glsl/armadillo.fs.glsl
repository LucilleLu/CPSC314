// Create shared variable. The value is given as the interpolation between normals computed in the vertex shader
varying vec3 interpolatedNormal;
varying vec3 directionVector;
float dotProduct;
float cos;

/* HINT: YOU WILL NEED MORE SHARED/UNIFORM VARIABLES TO COLOR ACCORDING TO COS(ANGLE) */

void main() {
    dotProduct = dot(interpolatedNormal, directionVector);
    cos = dotProduct / (length(interpolatedNormal) * length(directionVector));
    
  // Set final rendered color according to the surface normal
    if (length(directionVector)<1.0) {
        gl_FragColor = vec4(0, cos, 0, 1.0);
    } else {
        gl_FragColor = vec4(vec3(cos), 1.0); // REPLACE ME
    }
}
