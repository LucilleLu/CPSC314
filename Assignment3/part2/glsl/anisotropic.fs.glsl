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
    
	//AMBIENT
    vec3 light_AMB = ambientColor * kAmbient;

	//DIFFUSE
    float diffuse = max(0.0, dot(l, n));
    vec3 dIntensity = lightColor * diffuse;
    vec3 light_DFF = dIntensity * kDiffuse;

	//SPECULAR
    vec3 up = vec3(0.0, 1.0, 0.0);
    vec3 t = normalize(cross(n,up));
    vec3 h = normalize(l+v);
    vec3 b = normalize(cross(t,n));
    
    float ln = dot(l,n);
    float vn = dot(v,n);
    float vSqrt = sqrt(max(0.0,ln/vn));
    
    float htax = dot(h,t)/alphaX;
    float hbay = dot(h,b)/alphaY;
    float hn = dot(h,n);
    float vExp = exp(-2.0*((htax*htax+hbay*hbay)/(1.0+hn)));
    
    vec3 light_SPC = vec3(kSpecular * vSqrt * vExp);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	gl_FragColor = vec4(TOTAL, 0.0);

}
