module D2DGame.Rendering.Shape;

import D2D;

class Shape : Transformable, IDrawable
{
	abstract void draw(IRenderTarget target, ShaderProgram shader = null)
	{
	}

	public @property ref Texture texture()
	{
		return _texture;
	}

	private Texture _texture;
}
