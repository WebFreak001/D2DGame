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
module d2d;

public
{
	import bindbc.sdl;
	import bindbc.sdl.image;
	import bindbc.sdl.mixer;
	import bindbc.sdl.ttf;

	import bindbc.opengl;

	import soloader = bindbc.loader.sharedlib;

	import gl3n.aabb;
	import gl3n.ext.matrixstack;
	import gl3n.frustum;
	import gl3n.interpolate;
	import gl3n.linalg;
	import gl3n.plane;
	import gl3n.util;

	import std.math;

	import d2d.core.bytestream;
	import d2d.core.color3;
	import d2d.core.fpslimiter;
	import d2d.core.idisposable;
	import d2d.core.iverifiable;
	import d2d.core.transformable;
	import d2d.core.utils;

	import d2d.window.window;
	import d2d.window.windowevent;
	import d2d.window.windowflags;

	import d2d.rendering.bitmap;
	import d2d.rendering.color;
	import d2d.rendering.idrawable;
	import d2d.rendering.irendertarget;
	import d2d.rendering.mesh;
	import d2d.rendering.rectangleshape;
	import d2d.rendering.shader;
	import d2d.rendering.shaderprogram;
	import d2d.rendering.shape;
	import d2d.rendering.texture;

	import d2d.audio.music;
	import d2d.audio.sound;

	import d2d.font.bmfont;
	import d2d.font.bmtext;
	import d2d.font.ifont;
	import d2d.font.itext;
	import d2d.font.ttffont;
	import d2d.font.ttftext;

	import d2d.toolkit.game;
	import d2d.toolkit.input.keyboard;
	import d2d.toolkit.input.mouse;

	import std.string;
	import std.meta : AliasSeq;
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
MatrixStack!mat4 matrixStack = gl3n.ext.matrixstack.matrixStack!mat4();
/// Matrix stack for projection.
MatrixStack!mat4 projectionStack = gl3n.ext.matrixstack.matrixStack!mat4();

/// Initializes matrix stacks
static this()
{
	matrixStack.set(mat4.identity);
	projectionStack.set(mat4.orthographic(0, 1, 1, 0, -1, 1));
}
