//VARYING VAR
varying vec3 Normal_V;
varying vec3 Position_V;
varying vec4 PositionFromLight_V;
varying vec2 Texcoord_V;
varying vec4 ShadowCoord;


//UNIFORM VAR
uniform vec3 lightColorUniform;
uniform vec3 ambientColorUniform;
uniform vec3 lightDirectionUniform;

uniform float kAmbientUniform;
uniform float kDiffuseUniform;
uniform float kSpecularUniform;

uniform float shininessUniform;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

// PART D)
// Use this instead of directly sampling the shadowmap, as the float
// value is packed into 4 bytes as WebGL 1.0 (OpenGL ES 2.0) doesn't
// support floating point bufffers for the packing see depth.fs.glsl
float getShadowMapDepth(vec2 texCoord)
{
	vec4 v = texture2D(shadowMap, texCoord);
	const vec4 bitShift = vec4(1.0, 1.0/256.0, 1.0/(256.0 * 256.0), 1.0/(256.0*256.0*256.0));
	return dot(v, bitShift);
}

void main() {
    
    // PART A)
    vec3 texColor = texture2D(colorMap, Texcoord_V).xyz;
    vec3 texAO = texture2D(aoMap, Texcoord_V).xyz;
    
	// PART B) TANGENT SPACE NORMAL
    vec3 N_1 = normalize(texture2D(normalMap, Texcoord_V).xyz * 2.0 - 1.0);
    //* 2.0 - 1.0: tansfer from RBG 0~1 to Normal -1~1
    
	// PRE-CALCS
    vec3 N = normalize(Normal_V);
    
    vec3 up = vec3(0.0, 1.0, 0.0);
    vec3 T = cross(N, up);
    vec3 B = cross(N, T);
    mat3 TBNMatrix = mat3(T,B,N);

	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirectionUniform, 0.0))) * TBNMatrix;
	vec3 V = normalize(-Position_V) * TBNMatrix;
	vec3 H = normalize(V + L);

	// AMBIENT
	vec3 light_AMB = ambientColorUniform * kAmbientUniform;

	// DIFFUSE
    vec3 diffuse = kDiffuseUniform * lightColorUniform;
	vec3 light_DFF = diffuse * max(0.0, dot(N_1, L));

	// SPECULAR
	vec3 specular = kSpecularUniform * lightColorUniform;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, N_1)), shininessUniform);

	// TOTAL
    vec3 TOTAL = light_AMB*texAO+ light_DFF*texColor + light_SPC;


	// SHADOW
	// Fill in attenuation for shadow here
    vec3 ShadowCoord2;
    ShadowCoord2.x = (ShadowCoord.x/ShadowCoord.w)/2.0+0.5;
    ShadowCoord2.y = (ShadowCoord.y/ShadowCoord.w)/2.0+0.5;
    ShadowCoord2.z = (ShadowCoord.z/ShadowCoord.w)/2.0+0.5;
    
    float visibility = 1.0;
    float depth = getShadowMapDepth(ShadowCoord2.xy);
    
    if (depth < ShadowCoord2.z + 0.00001){
        visibility = 0.0;
    }
	
	gl_FragColor = vec4(TOTAL*visibility, 1.0);
}
