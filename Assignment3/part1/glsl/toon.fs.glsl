uniform vec3 lightDirection;
uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
uniform float alphaX;
uniform float alphaY;
varying vec3 n1;
varying vec3 v1;

void main() {
    
    vec3 n = normalize(n1);
    vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection,0.0)));
    vec3 v = normalize(-v1);
    
    //DIFFUSE
    float diffuse = max(0.0, dot(l, n));
    
	//TOTAL INTENSITY
	//TODO PART 1D: calculate light intensity	
    float lightIntensity = diffuse;

    vec4 resultingColor = vec4(0.0,0.0,0.0,0.0);
    
    //TODO PART 1D: change resultingColor based on lightIntensity (toon shading)
    
    if (lightIntensity > 0.95)
        resultingColor = vec4(1.0,0.5,0.5,1.0);
    else if (lightIntensity > 0.5)
        resultingColor = vec4(0.6,0.3,0.3,1.0);
    else if (lightIntensity > 0.25)
        resultingColor = vec4(0.4,0.2,0.2,1.0);
    else
        resultingColor = vec4(0.3,0.1,0.1,1.0);
    
   	//TODO PART 1D: change resultingColor to silhouette objects
    float angel = dot(v,n);
    if (angel<=0.22) {
        resultingColor = vec4(0.0,0.0,0.0,0.0);
    }
    
	gl_FragColor = resultingColor;
}
