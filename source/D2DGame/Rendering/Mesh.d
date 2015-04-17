module D2DGame.Rendering.Mesh;

import D2D;

/// Class containing mesh IDs and length for OpenGL drawing.
class RenderableMesh
{
	/// OpenGL id of the vao buffer.
	public uint bufferID;
	/// OpenGL array of the vbo buffers.
	public uint * vbos;
	/// Length of the index buffer.
	public uint indexLength;

	/// Constructor for creating a new RenderableMesh with existing data.
	public this(uint bufferID, uint * vbos, uint indexLength)
	{
		this.bufferID	 = bufferID;
		this.vbos		 = vbos;
		this.indexLength = indexLength;
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
		_vertices.length++; _vertices[_vertices.length - 1] = vertex;
	}

	/// Adds many vertices.
	public void addVertices(const vec3[] vertices)
	{
		_vertices ~= vertices;
	}

	/// Adds one index.
	public void addIndex(uint index)
	{
		_indices.length++; _indices[_indices.length - 1] = index;
	}

	/// Adds many indices.
	public void addIndices(const uint[] indices)
	{
		_indices ~= indices;
	}

	/// Adds one texture coordinate.
	public void addTexCoord(vec2 texCoord)
	{
		_texCoords.length++; _texCoords[_texCoords.length - 1] = texCoord;
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
			glDeleteBuffers(3, renderable.vbos);
			glDeleteVertexArrays(1, &renderable.bufferID);
			renderable = null;
		}
	}

	/// Generates the RenderableMesh from the previously defined vertices and makes `this` valid.
	public void create()
	{
		uint vao;
		glGenVertexArrays(1, &vao);
		glBindVertexArray(vao);

		uint* vbo = new uint[3].ptr;

		glGenBuffers(3, vbo);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[0]);
		glBufferData(GL_ARRAY_BUFFER, vec3.sizeof * vertices.length, vertices.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(0u, 3, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(0);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[1]);
		glBufferData(GL_ARRAY_BUFFER, vec2.sizeof * texCoords.length, texCoords.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(1u, 2, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(1);

		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vbo[2]);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, uint.sizeof * indices.length, indices.ptr, GL_STATIC_DRAW);

		glBindVertexArray(0);

		renderable = new RenderableMesh(vao, vbo, cast(uint) indices.length);
	}

	/// Renderable mesh when create got called. Before its `null`.
	public RenderableMesh renderable = null;

	private vec3[]		  _vertices;
	private vec3[]		  _normals;
	private vec2[]		  _texCoords;
	private uint[]		  _indices;
}
