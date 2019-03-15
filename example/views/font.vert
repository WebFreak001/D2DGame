#version 330
layout(location = 0) in vec3 in_position;
layout(location = 1) in vec2 in_tex;

uniform mat4 transform;
uniform mat4 projection;
uniform vec4 texRect;
uniform vec4 sizeRect;

out vec2 texCoord;

void main()
{
	gl_Position = projection * transform * vec4(in_position.xy * sizeRect.zw + sizeRect.xy, 0, 1);

	texCoord = texRect.xy + in_position.xy * texRect.zw;
}
