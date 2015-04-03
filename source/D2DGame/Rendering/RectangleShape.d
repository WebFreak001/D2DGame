module D2DGame.Rendering.RectangleShape;

import D2D;

class RectangleShape : Shape
{
private:

	Mesh _mesh;
public:
	this()
	{
		_mesh = new Mesh();
	}

	void setSize(const vec2 size)
	{
		_mesh.dispose();
		_mesh = new Mesh();
		_mesh.addVertices([vec3(0, 0, 0), vec3(size.x, 0, 0), vec3(size.x, size.y, 0), vec3(0, size.y, 0)]);
		_mesh.addTexCoords([vec2(0, 0), vec2(1, 0), vec2(1, 1), vec2(0, 1)]);
		_mesh.addIndices([0, 1, 2, 0, 2, 3]);
		_mesh.create();
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		matrixStack.push();
		matrixStack.top = matrixStack.top * transform;
		if (texture !is null)
			texture.bind(0);
		target.draw(_mesh, shader);
		matrixStack.pop();
	}
}