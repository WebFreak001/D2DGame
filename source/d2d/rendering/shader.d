module d2d.rendering.shader;

import d2d;

/// All valid types of shaders for the `Shader` class.
enum ShaderType : ubyte
{
	/// Vertex Shader
	Vertex,
	/// Tessellation Control Shader
	TessControl,
	/// Tessellation Evaluation Shader
	TessEvaluation,
	/// Geometry Shader
	Geometry,
	/// Fragment/Pixel Shader
	Fragment
}

/// Class containing a single shader for combining in a ShaderProgram.
class Shader : IVerifiable
{
	/// Loads the shader content into memory.
	public bool load(ShaderType type, string content)
	{
		this.content = content;
		switch (type)
		{
		case ShaderType.Vertex:
			_id = glCreateShader(GL_VERTEX_SHADER);
			break;
		case ShaderType.TessControl:
			_id = glCreateShader(GL_TESS_CONTROL_SHADER);
			break;
		case ShaderType.TessEvaluation:
			_id = glCreateShader(GL_TESS_EVALUATION_SHADER);
			break;
		case ShaderType.Geometry:
			_id = glCreateShader(GL_GEOMETRY_SHADER);
			break;
		case ShaderType.Fragment:
			_id = glCreateShader(GL_FRAGMENT_SHADER);
			break;
		default:
			throw new Exception("ShaderType " ~ to!string(type) ~ " is not defined!");
		}

		const int len = cast(const(int)) content.length;

		glShaderSource(_id, 1, [content.ptr].ptr, &len);
		return true;
	}

	/// Creates a shader, loads the content and compiles it in one function.
	static Shader create(ShaderType type, string content)
	{
		Shader shader = new Shader();
		shader.load(type, content);
		shader.compile();
		return shader;
	}

	/// Compiles the shader and throws an Exception if an error occured.
	/// Will automatically be called when attaching the shader to a ShaderProgram instance.
	public bool compile()
	{
		if (compiled)
			return true;
		glCompileShader(_id);
		int success = 0;
		glGetShaderiv(_id, GL_COMPILE_STATUS, &success);

		if (success == 0)
		{
			int logSize = 0;
			glGetShaderiv(_id, GL_INFO_LOG_LENGTH, &logSize);

			char* log = new char[logSize].ptr;
			glGetShaderInfoLog(_id, logSize, &logSize, &log[0]);

			throw new Exception(cast(string) log[0 .. logSize]);
		}
		compiled = true;
		return true;
	}

	/// The OpenGL id of this shader.
	public @property uint id()
	{
		return _id;
	}

	/// Checks if this shader is valid.
	public @property bool valid()
	{
		return _id > 0;
	}

	private uint _id = 0;
	private string content;
	private bool compiled = false;
}
