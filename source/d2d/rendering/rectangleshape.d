module d2d.rendering.rectangleshape;

import d2d;

/**
 * A resizable rectangle containing a texture.
 * Examples:
 * ---
 * auto rect = new RectangleShape();
 * rect.setSize(vec2(100, 50)); // 100x50 px
 * window.draw(rect);
 * ---
 */
class RectangleShape : Shape, IDisposable, IVerifiable
{
protected:
	Mesh _mesh; // TODO: Only 1 Mesh

public:
	this()
	{
		_mesh = new Mesh();
		setSize(vec2(1, 1));
	}

	~this()
	{
		dispose();
	}

	override @property bool valid()
	{
		return _mesh.valid;
	}

	override void dispose()
	{
		if (_mesh.valid)
		{
			_mesh.dispose();
		}
	}

	/// Sets the new size and creates a new mesh after disposing the old mesh.
	void setSize(const vec2 size)
	{
		_mesh.dispose();
		_mesh = new Mesh();
		_mesh.addVertices([vec3(0, 0, 0), vec3(size.x, 0, 0), vec3(size.x, size.y, 0), vec3(0, size.y, 0)]);
		_mesh.addTexCoords([vec2(0, 0), vec2(1, 0), vec2(1, 1), vec2(0, 1)]);
		_mesh.addIndices([0, 1, 2, 0, 2, 3]);
		_mesh.create();
	}

	/// Sets the current transformation matrix and draws this onto the target.
	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		if (_mesh.valid)
		{
			matrixStack.push();
			matrixStack.top = matrixStack.top * transform;
			if (texture !is null)
				texture.bind(0);
			target.draw(_mesh, shader);
			matrixStack.pop();
		}
	}
}
