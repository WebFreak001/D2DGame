module D2DGame.Rendering.Shader;

import D2D;

enum ShaderType : ubyte
{
	Vertex, TessControl, TessEvaluation, Geometry, Fragment
}

class Shader
{
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

	public @property uint id()
	{
		return _id;
	}

	private uint   _id = 0;
	private string content;
	private bool   compiled = false;
}
