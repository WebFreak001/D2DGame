module D2DGame.Rendering.IDrawable;

import D2D;

/// Basic interface for everything that is able to draw.
interface IDrawable
{
	/// Will get called by `IRenderTarget.draw(IDrawable);
	void draw(IRenderTarget target, ShaderProgram shader = null);
}
