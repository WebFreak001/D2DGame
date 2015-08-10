module D2DGame.Rendering.IRenderTarget;

import D2D;

/// Interface for containers being able to draw elements.
interface IRenderTarget
{
	/// Set active container.
	void bind();
	/// Resize the container texture to the new width and height.
	void resize(int width, int height);
	/// Create a container texture in the given resolution.
	void create(int width, int height);

	/// Clears the container texture by calling `bind()` -> `glClearColor(r, g, b, 1)` -> `glClear(GL_COLOR_BUFFER_BIT)`.
	final void clear(float r, float g, float b)
	{
		bind();
		glClearColor(r, g, b, 1);
		glClear(GL_COLOR_BUFFER_BIT);
	}

	/// Draws drawable using optional shader onto this. This will call `drawable.draw(this, shader);`
	/// If shader is `null`, `ShaderProgram.default` is gonna be used.
	final void draw(IDrawable drawable, ShaderProgram shader = null)
	{
		bind();
		drawable.draw(this, shader);
	}

	/// Draws raw geometry to the container texture using an optional shader.
	/// If shader is null, ShaderProgram.default is gonna be used.
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

	/// Returns the result of the container texture.
	@property Texture texture();
}
