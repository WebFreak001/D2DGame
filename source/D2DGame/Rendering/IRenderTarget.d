module D2DGame.Rendering.IRenderTarget;

import D2D;

interface IRenderTarget
{
	void bind();
	void resize(int width, int height);
	void create(int width, int height);

	final void clear(float r, float g, float b)
	{
		bind();
		glClearColor(r, g, b, 1);
		glClear(GL_COLOR_BUFFER_BIT);
	}

	final void draw(IDrawable drawable, ShaderProgram shader = null)
	{
		bind();
		drawable.draw(this, shader);
	}

	final void draw(Mesh mesh, ShaderProgram shader = null)
	{
		bind();

		if (shader is null)
			shader = ShaderProgram.defaultShader;
		shader.bind();
		shader.set("transform", matrixStack.top);
		shader.set("projection", projectionStack.top);
		glBindVertexArray(mesh.renderable.bufferID);
		glDrawElements(GL_TRIANGLES, mesh.renderable.indexLength, GL_UNSIGNED_INT, null);
	}

	@property Texture texture();
}
