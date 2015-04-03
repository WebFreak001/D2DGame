module D2D;

public
{
	import derelict.sdl2.sdl;
	import derelict.sdl2.image;
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

	import std.string;
	import std.typecons;
}

pure mat4 rotate2d(mat4 mat, float alpha)
{
	mat = mat.rotatez(alpha);
	return mat;
}

pure mat4 scale2d(mat4 mat, float x, float y)
{
	mat = mat.scale(x, y, 1);
	return mat;
}

pure mat4 translate2d(mat4 mat, float x, float y)
{
	mat = mat.translate(x, y, 0);
	return mat;
}

MatrixStack!mat4 matrixStack;
MatrixStack!mat4 projectionStack;

static this()
{
	matrixStack.set(mat4.identity);
	projectionStack.set(mat4.orthographic(0, 1, 1, 0, -1, 1));
}
