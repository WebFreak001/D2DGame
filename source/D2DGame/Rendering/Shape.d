module D2DGame.Rendering.Shape;

import D2D;

/// Base class for Shapes.
class Shape : Transformable, IDrawable
{
	/// Abstract draw function.
	abstract void draw(IRenderTarget target, ShaderProgram shader = null)
	{
	}

	/// The assigned texture.
	public @property ref Texture texture()
	{
		return _texture;
	}

	private Texture _texture;
}
