module d2d.rendering.rectangleshape;

import d2d;

/**
 * A resizable rectangle containing a texture.
 * Examples:
 * ---
 * auto rect = new RectangleShape();
 * rect.size = vec2(100, 50); // 100x50 px
 * rect.create();
 * window.draw(rect);
 *
 * // OR
 *
 * auto rect = RectangleShape.create(vec2(0, 0), vec2(100, 50)); // At 0,0 with size 100x50 px
 * window.draw(rect);
 * ---
 */
class RectangleShape : Shape, IDisposable, IVerifiable
{
protected:
	Mesh _mesh; // TODO: Only 1 Mesh
	vec4 _texCoords = vec4(0, 0, 1, 1);
	vec2 _size = vec2(1, 1);

public:
	///
	this()
	{
		_mesh = new Mesh();
		create();
	}

	~this()
	{
		_mesh = null;
		dispose();
	}

	/// Returns if the mesh is valid.
	override @property bool valid()
	{
		return _mesh.valid;
	}

	/// Property for the size of the rectangle.
	@property ref vec2 size()
	{
		return _size;
	}

	/// Property for begin xy and end xy using a vec4 for texture coordinates.
	@property ref vec4 texCoords()
	{
		return _texCoords;
	}

	override void dispose()
	{
		if (_mesh && _mesh.valid)
		{
			_mesh.dispose();
			_mesh = null;
		}
	}

	/// Creates a new mesh after disposing the old mesh.
	void create()
	{
		_mesh.dispose();
		_mesh = new Mesh();
		_mesh.addVertices([vec3(0, 0, 0), vec3(_size.x, 0, 0), vec3(_size.x, _size.y, 0), vec3(0, _size.y, 0)]);
		_mesh.addTexCoords([vec2(_texCoords.x, _texCoords.y), vec2(_texCoords.z, _texCoords.y), vec2(_texCoords.z, _texCoords.w), vec2(_texCoords.x, _texCoords.w)]);
		_mesh.addIndices([0, 1, 2, 0, 2, 3]);
		_mesh.create();
	}

	/// Sets the current transformation matrix and draws this onto the target.
	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		assert(_mesh.valid, "Mesh not valid!");
		matrixStack.push();
		matrixStack.top = matrixStack.top * transform;
		if (texture !is null)
			texture.bind(0);
		target.draw(_mesh, shader);
		matrixStack.pop();
	}

	///
	static RectangleShape create(vec2 position, vec2 size)
	{
		auto shape = new RectangleShape();
		shape.position = position;
		shape.size = size;
		shape.create();
		return shape;
	}

	///
	static RectangleShape create(Texture texture, vec2 position, vec2 size)
	{
		auto shape = new RectangleShape();
		shape.texture = texture;
		shape.position = position;
		shape.size = size;
		shape.create();
		return shape;
	}

	///
	static RectangleShape create(Texture texture, vec2 position, vec2 size, vec4 texCoords)
	{
		auto shape = new RectangleShape();
		shape.texture = texture;
		shape.position = position;
		shape.size = size;
		shape.texCoords = texCoords;
		shape.create();
		return shape;
	}
}
