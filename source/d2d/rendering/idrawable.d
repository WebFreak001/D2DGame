module d2d.rendering.idrawable;

import d2d;

/// Basic interface for everything that is able to draw.
interface IDrawable
{
	/// Will get called by `IRenderTarget.draw(IDrawable);`
	void draw(IRenderTarget target, ShaderProgram shader = null);
}
