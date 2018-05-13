uniform vec3 lightDirection;
uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;
varying vec3 n1;
varying vec3 v1;

void main() {

    vec3 n = normalize(n1);
    vec3 l = normalize(vec3(viewMatrix * vec4(lightDirection,0.0)));
    vec3 v = normalize(-v1);

	//AMBIENT
	vec3 light_AMB = ambientColor * kAmbient;

    //DIFFUSE
    float diffuse = max(0.0, dot(l, n));
    vec3 dIntensity = lightColor * diffuse;
    vec3 light_DFF = dIntensity * kDiffuse;

	//SPECULAR
    vec3 h = normalize(l+v);
    float specular = max(0.0, dot(h, n));
    float sIntensity = pow(specular, shininess);
	vec3 light_SPC = vec3(sIntensity) * kSpecular;

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}
