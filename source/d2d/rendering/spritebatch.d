module d2d.rendering.spritebatch;

import crunch;

import d2d;

enum DrawOrigin
{
	topLeft = 0,
	topCenter = 1,
	topRight = 2,
	middleLeft = 4,
	middleCenter = 5,
	middleRight = 6,
	bottomLeft = 8,
	bottomCenter = 9,
	bottomRight = 10
}

class SpriteBatchImpl(uint maxVertexCount) : IDisposable, IVerifiable, IDrawable
{
	struct Vertex
	{
		vec2 position;
		vec2 texCoord;
		vec4 color;
	}

	Vertex[maxVertexCount] vertices;
	RenderableMesh renderable;

	private Texture texture;
	private uint index;
	private uint vao;
	private uint vbo;
	private bool running;

	/// Regular texture shader.
	public static ShaderProgram spriteShader;

	static void load()
	{
		spriteShader = new ShaderProgram();
		Shader vertex = new Shader();
		vertex.load(ShaderType.Vertex, "#version 330
layout(location = 0) in vec3 in_position;
layout(location = 1) in vec2 in_tex;
layout(location = 2) in vec4 in_color;

uniform mat4 transform;
uniform mat4 projection;

out vec2 texCoord;
out vec4 color;

void main()
{
	gl_Position = projection * transform * vec4(in_position, 1);

	texCoord = in_tex;
	color = in_color;
}
");
		Shader fragment = new Shader();
		fragment.load(ShaderType.Fragment, "#version 330
uniform sampler2D tex;

in vec2 texCoord;
in vec4 color;

layout(location = 0) out vec4 out_frag_color;

void main()
{
	out_frag_color = texture(tex, texCoord) * color;
}
");
		spriteShader.attach(vertex);
		spriteShader.attach(fragment);
		spriteShader.link();
		spriteShader.bind();
		spriteShader.registerUniform("tex");
		spriteShader.registerUniform("transform");
		spriteShader.registerUniform("projection");
		spriteShader.set("tex", 0);
	}

	this()
	{
		glGenVertexArrays(1, &vao);
		glBindVertexArray(vao);

		glGenBuffers(1, &vbo);
		glBindBuffer(GL_ARRAY_BUFFER, vbo);
		glBufferData(GL_ARRAY_BUFFER, maxVertexCount * Vertex.sizeof, &vertices[0], GL_DYNAMIC_DRAW);
		glEnableVertexAttribArray(0);
		glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, Vertex.sizeof,
				cast(void*)(Vertex.position.offsetof));
		glEnableVertexAttribArray(1);
		glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, Vertex.sizeof,
				cast(void*)(Vertex.texCoord.offsetof));
		glEnableVertexAttribArray(2);
		glVertexAttribPointer(2, 4, GL_FLOAT, GL_FALSE, Vertex.sizeof,
				cast(void*)(Vertex.color.offsetof));

		glBindVertexArray(0);

		renderable = new RenderableMesh(vao, 0, false);

		if (spriteShader is null)
			load();
	}

	void dispose()
	{
		if (valid)
		{
			renderable = null;
		}
	}

	@property bool valid()
	{
		return renderable !is null;
	}

	void draw(IRenderTarget target, ShaderProgram shader = spriteShader)
	{
		texture.bind();
		target.draw(renderable, shader);
	}

	void begin(Texture texture)
	{
		if (running)
			throw new Exception("Tried to begin when begin was already called");

		index = 0;
		running = true;
		this.texture = texture;
	}

	void end()
	{
		if (!running)
			throw new Exception("Tried to end when begin was not called");

		running = false;
		glBindBuffer(GL_ARRAY_BUFFER, vbo);
		glBufferSubData(GL_ARRAY_BUFFER, 0, index * Vertex.sizeof, &vertices[0]);
		renderable.count = index;
	}

	void drawSprite(Crunch.Image image, vec2 position, vec4 color = vec4(1))
	{
		drawSprite(image, position, vec2(1, 1), color);
	}

	void drawSprite(Crunch.Image image, vec2 position, float rotation,
			DrawOrigin origin, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		drawSprite(image, position, vec2(1, 1), rotation, origin, originOffset, color);
	}

	void drawSprite(Crunch.Image image, vec2 position, float scale, vec4 color = vec4(1))
	{
		drawSprite(image, position, vec2(scale, scale), color);
	}

	void drawSprite(Crunch.Image image, vec2 position, float scale, float rotation,
			DrawOrigin origin, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		drawSprite(image, position, vec2(scale, scale), rotation, origin, originOffset, color);
	}

	void drawSprite(Crunch.Image sprite, vec2 position, vec2 scale, vec4 color = vec4(1))
	{
		vec2 uvScale = vec2(1.0f / texture.width, 1.0f / texture.height);
		vec2 size = vec2(sprite.width, sprite.height);
		vec2 drawSize = vec2(size.x * scale.x, size.y * scale.y);

		drawRectangle(position, drawSize, rect.dim(sprite.x, sprite.y, size).scale(uvScale), color);
	}

	void drawSprite(Crunch.Image sprite, vec2 position, vec2 scale, float rotation,
			DrawOrigin origin = DrawOrigin.topLeft, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		vec2 uvScale = vec2(1.0f / texture.width, 1.0f / texture.height);
		vec2 size = vec2(sprite.width, sprite.height);
		vec2 drawSize = vec2(size.x * scale.x, size.y * scale.y);

		drawRectangle(position, drawSize, rect.dim(sprite.x, sprite.y, size)
				.scale(uvScale), rotation, origin, originOffset, color);
	}

	void drawSprite(Crunch.Image sprite, mat3 transformation, vec4 color = vec4(1))
	{
		vec2 uvScale = vec2(1.0f / texture.width, 1.0f / texture.height);
		vec2 size = vec2(sprite.width, sprite.height);

		drawRectangle(rect.dim(size), rect.dim(sprite.x, sprite.y, size)
				.scale(uvScale), transformation, color);
	}

	void drawRectangle(vec2 position, vec2 size, vec4 color = vec4(1))
	{
		drawRectangle(rect.dim(position, size), color);
	}

	void drawRectangle(vec2 position, vec2 size, float rotation,
			DrawOrigin origin = DrawOrigin.topLeft, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		drawRectangle(rect.dim(position, size), rotation, origin, originOffset, color);
	}

	void drawRectangle(rect rectangle, vec4 color = vec4(1))
	{
		drawRectangle(rectangle, rect(0, 0, 1, 1), color);
	}

	void drawRectangle(rect rectangle, float rotation,
			DrawOrigin origin = DrawOrigin.topLeft, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		drawRectangle(rectangle, rect(0, 0, 1, 1), rotation, origin, originOffset, color);
	}

	void drawRectangle(vec2 position, vec2 size, rect uv, vec4 color = vec4(1))
	{
		drawRectangle(rect.dim(position, size), uv, color);
	}

	void drawRectangle(vec2 position, vec2 size, rect uv, float rotation,
			DrawOrigin origin = DrawOrigin.topLeft, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		drawRectangle(rect.dim(position, size), uv, rotation, origin, originOffset, color);
	}

	void drawRectangle(rect rectangle, rect uv, vec4 color = vec4(1))
	{
		if (!running)
			throw new Exception("Tried to draw when begin was not called");

		vertices[index++] = Vertex(rectangle.pos00, uv.pos00, color);
		vertices[index++] = Vertex(rectangle.pos10, uv.pos10, color);
		vertices[index++] = Vertex(rectangle.pos01, uv.pos01, color);

		vertices[index++] = Vertex(rectangle.pos01, uv.pos01, color);
		vertices[index++] = Vertex(rectangle.pos10, uv.pos10, color);
		vertices[index++] = Vertex(rectangle.pos11, uv.pos11, color);
	}

	void drawRectangle(rect rectangle, rect uv, mat3 transformation, vec4 color = vec4(1))
	{
		if (!running)
			throw new Exception("Tried to draw when begin was not called");

		vertices[index++] = Vertex((transformation * vec3(rectangle.pos00, 1)).xy, uv.pos00, color);
		vertices[index++] = Vertex((transformation * vec3(rectangle.pos10, 1)).xy, uv.pos10, color);
		vertices[index++] = Vertex((transformation * vec3(rectangle.pos01, 1)).xy, uv.pos01, color);

		vertices[index++] = Vertex((transformation * vec3(rectangle.pos01, 1)).xy, uv.pos01, color);
		vertices[index++] = Vertex((transformation * vec3(rectangle.pos10, 1)).xy, uv.pos10, color);
		vertices[index++] = Vertex((transformation * vec3(rectangle.pos11, 1)).xy, uv.pos11, color);
	}

	void drawRectangle(rect rectangle, rect uv, float rotation,
			DrawOrigin origin = DrawOrigin.topLeft, vec2 originOffset = vec2(0), vec4 color = vec4(1))
	{
		if (!running)
			throw new Exception("Tried to draw when begin was not called");

		vec2 offset = originOffset;

		auto horizontal = cast(int) origin & 0b11;
		auto vertical = cast(int) origin & 0b1100;

		offset.x -= rectangle.x;
		offset.y -= rectangle.y;

		vec2 drawOffset = vec2(0);

		if (horizontal == 1)
		{
			drawOffset.x = -rectangle.width * 0.5;
			offset.x -= rectangle.width * 0.5;
		}
		else if (horizontal == 2)
		{
			drawOffset.x = -rectangle.width;
			offset.x -= rectangle.width;
		}

		if (vertical == 4)
		{
			drawOffset.y = -rectangle.height * 0.5;
			offset.y -= rectangle.height * 0.5;
		}
		else if (vertical == 8)
		{
			drawOffset.y = -rectangle.height;
			offset.y -= rectangle.height;
		}

		float s = -sin(rotation);
		float c = cos(rotation);

		mat2 m = mat2(c, -s, s, c);

		vertices[index++] = Vertex((rectangle.pos00 + offset) * m - offset + drawOffset,
				uv.pos00, color);
		vertices[index++] = Vertex((rectangle.pos10 + offset) * m - offset + drawOffset,
				uv.pos10, color);
		vertices[index++] = Vertex((rectangle.pos01 + offset) * m - offset + drawOffset,
				uv.pos01, color);

		vertices[index++] = Vertex((rectangle.pos01 + offset) * m - offset + drawOffset,
				uv.pos01, color);
		vertices[index++] = Vertex((rectangle.pos10 + offset) * m - offset + drawOffset,
				uv.pos10, color);
		vertices[index++] = Vertex((rectangle.pos11 + offset) * m - offset + drawOffset,
				uv.pos11, color);
	}

	void drawTriangle(Vertex[3] tri)
	{
		vertices[index++] = tri[0];
		vertices[index++] = tri[1];
		vertices[index++] = tri[2];
	}
}

alias SpriteBatch = SpriteBatchImpl!(65536);
