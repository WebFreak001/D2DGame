module D2DGame.Rendering.IDrawable;

import D2D;

interface IDrawable
{
	void draw(IRenderTarget target, ShaderProgram shader = null);
}
