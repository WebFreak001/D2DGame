/** Module for including all D2DGame components.
 * Examples:
 * ---
 * import D2D;
 *
 * void main()
 * {
 *     Window window = new Window();
 *
 *     Event event; // Or WindowEvent
 *     while(window.open)
 *     {
 *         while (window.pollEvent(event))
 *         {
 *             if(event.type == Event.Type.Quit)
 *                 window.close();
 *         }
 *         window.clear();
 *
 *         // Update & Render here
 *
 *         window.display();
 *     }
 * }
 * ---
 */
module D2D;

public
{
	import derelict.sdl2.sdl;
	import derelict.sdl2.image;
	import derelict.sdl2.mixer;
	import derelict.sdl2.ttf;
	import derelict.opengl3.gl3;

	import gl3n.aabb;
	import gl3n.frustum;
	import gl3n.interpolate;
	import gl3n.linalg;
	import gl3n.plane;
	import gl3n.util;
	import gl3n.ext.matrixstack;

	import std.math;

	import D2DGame.Core.IVerifiable;
	import D2DGame.Core.IDisposable;
	import D2DGame.Core.Transformable;
	import D2DGame.Core.Color3;
	import D2DGame.Core.FPSLimiter;

	import D2DGame.Window.Window;
	import D2DGame.Window.WindowEvent;
	import D2DGame.Window.WindowFlags;

	import D2DGame.Rendering.IRenderTarget;
	import D2DGame.Rendering.Mesh;
	import D2DGame.Rendering.IDrawable;
	import D2DGame.Rendering.Texture;
	import D2DGame.Rendering.Bitmap;
	import D2DGame.Rendering.Color;
	import D2DGame.Rendering.Shader;
	import D2DGame.Rendering.ShaderProgram;
	import D2DGame.Rendering.Shape;
	import D2DGame.Rendering.RectangleShape;

	import D2DGame.Audio.Music;
	import D2DGame.Audio.Sound;

	import D2DGame.Toolkit.Game;

	import std.string;
	import std.typecons;
}

/// 2D rotation on a mat4.
pure mat4 rotate2d(mat4 mat, float alpha)
{
	mat = mat.rotatez(alpha);
	return mat;
}

/// 2D scale on a mat4.
pure mat4 scale2d(mat4 mat, float x, float y)
{
	mat = mat.scale(x, y, 1);
	return mat;
}

/// 2D translation on a mat4.
pure mat4 translate2d(mat4 mat, float x, float y)
{
	mat = mat.translate(x, y, 0);
	return mat;
}

/// Matrix stack for modelview (like glPopMatrix, glPushMatrix).
MatrixStack!mat4 matrixStack;
/// Matrix stack for projection.
MatrixStack!mat4 projectionStack;

/// Initializes matrix stacks
static this()
{
	matrixStack.set(mat4.identity);
	projectionStack.set(mat4.orthographic(0, 1, 1, 0, -1, 1));
}
