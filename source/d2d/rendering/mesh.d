module d2d.rendering.mesh;

import d2d;

/// Class containing mesh IDs and length for OpenGL drawing.
class RenderableMesh
{
	/// OpenGL id of the buffer.
	public uint bufferID;
	/// Length of the index/data buffer.
	public uint count;
	/// Offset index in the index/data buffer.
	public uint start;
	/// OpenGL primitive type.
	public GLenum primitiveType = GL_TRIANGLES;
	/// Is this an indexed mesh.
	public bool indexed = true;
	/// Type of indices.
	public GLenum indexType = GL_UNSIGNED_INT;

	/// OpenGL array of the vbo buffers.
	deprecated("no longer used") public uint[] vbos;

	deprecated alias indexLength = count;

	uint indexStride() const @property
	{
		if (!indexed)
			return 0;

		switch (indexType)
		{
		case GL_UNSIGNED_BYTE:
			return 1;
		case GL_UNSIGNED_SHORT:
			return 2;
		case GL_UNSIGNED_INT:
			return 4;
		default:
			return 0;
		}
	}

	/// Constructor for creating a new RenderableMesh with existing data.
	deprecated public this(uint bufferID, uint[] vbos, uint indexLength)
	{
		this.bufferID = bufferID;
		this.vbos = vbos;
		this.count = indexLength;
		indexed = true;
	}

	/// Constructor for creating a new RenderableMesh with existing data.
	public this(uint bufferID, uint count, bool indexed)
	{
		this.bufferID = bufferID;
		this.count = count;
		this.indexed = indexed;
	}
}

/// Class for raw geometry.
class Mesh : IDisposable, IVerifiable
{
	~this()
	{
		dispose();
	}

	/// Array of the vertices.
	public @property vec3[] vertices()
	{
		return _vertices;
	}

	/// Array of the indices.
	public @property uint[] indices()
	{
		return _indices;
	}

	/// Array of the texture coordinates.
	public @property vec2[] texCoords()
	{
		return _texCoords;
	}

	/// Checks if this Mesh can be drawn.
	public @property bool valid()
	{
		return renderable !is null;
	}

	/// Adds one vertex.
	public void addVertex(vec3 vertex)
	{
		_vertices ~= vertex;
	}

	/// Adds many vertices.
	public void addVertices(const vec3[] vertices)
	{
		_vertices ~= vertices;
	}

	/// Adds one index.
	public void addIndex(uint index)
	{
		_indices ~= index;
	}

	/// Adds many indices.
	public void addIndices(const uint[] indices)
	{
		_indices ~= indices;
	}

	/// Adds one texture coordinate.
	public void addTexCoord(vec2 texCoord)
	{
		_texCoords ~= texCoord;
	}

	/// Adds many texture coordinates.
	public void addTexCoords(const vec2[] texCoords)
	{
		_texCoords ~= texCoords;
	}

	/// Deletes the mesh from memory and cleans up.
	public void dispose()
	{
		if (valid)
		{
			glDeleteVertexArrays(1, &vao);
			glDeleteBuffers(vbo.length, &vbo[0]);
			glDeleteVertexArrays(1, &renderable.bufferID);
			renderable = null;
		}
	}

	/// Generates the RenderableMesh from the previously defined vertices and makes `this` valid.
	public void create()
	{
		glGenVertexArrays(1, &vao);
		glBindVertexArray(vao);

		glGenBuffers(vbo.length, &vbo[0]);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[0]);
		glBufferData(GL_ARRAY_BUFFER, vec3.sizeof * vertices.length, vertices.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(0u, 3, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(0);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[1]);
		glBufferData(GL_ARRAY_BUFFER, vec2.sizeof * texCoords.length, texCoords.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(1u, 2, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(1);

		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vbo[2]);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, uint.sizeof * indices.length,
				indices.ptr, GL_STATIC_DRAW);

		glBindVertexArray(0);

		renderable = new RenderableMesh(vao, cast(uint) indices.length, true);
	}

	/// Renderable mesh when create got called. Before its `null`.
	public RenderableMesh renderable = null;

	private uint vao;
	private uint[3] vbo;

	private vec3[] _vertices;
	private vec3[] _normals;
	private vec2[] _texCoords;
	private uint[] _indices;
}
