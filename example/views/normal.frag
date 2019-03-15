#version 330

uniform sampler2D tex;
uniform sampler2D tex2;

uniform mat4 invTransWorld;

in vec2 texCoord;

layout(location = 0) out vec4 out_frag_color;

void main()
{
	out_frag_color = vec4(
		texture(tex, texCoord).rgb
		* dot(
			normalize(texture(tex2, texCoord).xyz * 2 - 1) * mat3(invTransWorld),
			normalize(vec3(-0.5, 0.5, 1))
		),
		texture(tex, texCoord).a
	);
}
