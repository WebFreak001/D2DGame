module D2DGame.Rendering.Mesh;

import D2D;

class RenderableMesh
{
	public uint bufferID;
	public uint * vbos;
	public uint indexLength;

	public this(uint bufferID, uint * vbos, uint indexLength)
	{
		this.bufferID	 = bufferID;
		this.vbos		 = vbos;
		this.indexLength = indexLength;
	}
}

class Mesh : IDisposable
{
	~this()
	{
		dispose();
	}

	public @property vec3[] vertices()
	{
		return _vertices;
	}
	public @property uint[] indices()
	{
		return _indices;
	}
	public @property vec2[] texCoords()
	{
		return _texCoords;
	}

	public void addVertex(vec3 vertex)
	{
		_vertices.length++; _vertices[_vertices.length - 1] = vertex;
	}
	public void addVertices(const vec3[] vertices)
	{
		_vertices ~= vertices;
	}

	public void addIndex(uint index)
	{
		_indices.length++; _indices[_indices.length - 1] = index;
	}
	public void addIndices(const uint[] indices)
	{
		_indices ~= indices;
	}

	public void addTexCoord(vec2 texCoord)
	{
		_texCoords.length++; _texCoords[_texCoords.length - 1] = texCoord;
	}
	public void addTexCoords(const vec2[] texCoords)
	{
		_texCoords ~= texCoords;
	}

	public void dispose()
	{
		if (renderable !is null)
		{
			glDeleteBuffers(3, renderable.vbos);
			glDeleteVertexArrays(1, &renderable.bufferID);
		}
	}

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

	public RenderableMesh renderable = null;

	private vec3[]		  _vertices;
	private vec3[]		  _normals;
	private vec2[]		  _texCoords;
	private uint[]		  _indices;
}
