module D2DGame.Rendering.Texture;

import D2D;

///
enum TextureFilterMode : int
{
	Linear				 = GL_LINEAR,                 /// `GL_LINEAR` sampling. Smooth looking textures.
	Nearest				 = GL_NEAREST,                /// `GL_NEAREST` sampling. No smoothing.
	NearestMipmapNearest = GL_NEAREST_MIPMAP_NEAREST, /// `GL_NEAREST_MIPMAP_NEAREST` sampling. Not usable in mag filter.
	LinearMipmapNearest	 = GL_LINEAR_MIPMAP_NEAREST,  /// `GL_LINEAR_MIPMAP_NEAREST` sampling. Not usable in mag filter.
	NearestMipmapLinear	 = GL_NEAREST_MIPMAP_LINEAR,  /// `GL_NEAREST_MIPMAP_LINEAR` sampling. Not usable in mag filter.
	LinearMipmapLinear	 = GL_LINEAR_MIPMAP_LINEAR,   /// `GL_LINEAR_MIPMAP_LINEAR` sampling. Not usable in mag filter.
}

///
enum TextureClampMode : int
{
	ClampToBorder = GL_CLAMP_TO_BORDER, /// Clamps the texture coordinate at the border. Will include a border.
	ClampToEdge	  = GL_CLAMP_TO_EDGE,   /// Clamps the texture coordinate at the edge of the texture.
	Repeat		  = GL_REPEAT,          /// Repeats the texture coordinate when being larger than 1.
	Mirror		  = GL_MIRRORED_REPEAT  /// Repeats the texture coordinate and mirrors every time for better tiling.
}

/// Texture for drawing using OpenGL.
class Texture : IDisposable, IVerifiable
{
	/// Enable mipmaps. Disabled by default.
	public bool enableMipMaps = false;

	///
	public TextureFilterMode minFilter = TextureFilterMode.Linear;
	///
	public TextureFilterMode magFilter = TextureFilterMode.Linear;

	///
	public TextureClampMode wrapX = TextureClampMode.Repeat;
	///
	public TextureClampMode wrapY = TextureClampMode.Repeat;

	private int				inMode, mode;
	private uint			_id;
	private uint			_width, _height;

	///
	public @property uint id()
	{
		return _id;
	}

	///
	public @property uint width()
	{
		return _width;
	}

	///
	public @property uint height()
	{
		return _height;
	}

	/// 1x1 texture containing a white pixel for solid shapes.
	public static @property Texture white()
	{
		return _white;
	}

	private static Texture _white;

	public static void load()
	{
		_white = new Texture();
		_white.create(1, 1, cast(ubyte[])[255, 255, 255, 255]);
	}

	///
	public this() {}

	/// Creates and loads the texture with the given filters.
	public this(string file, TextureFilterMode min = TextureFilterMode.Linear, TextureFilterMode mag = TextureFilterMode.Linear, TextureClampMode wrapX = TextureClampMode.Repeat, TextureClampMode wrapY = TextureClampMode.Repeat)
	{
		if (min == TextureFilterMode.LinearMipmapLinear || min == TextureFilterMode.LinearMipmapNearest)
			enableMipMaps = true;
		minFilter  = min;
		magFilter  = mag;
		this.wrapX = wrapX;
		this.wrapY = wrapY;
		fromBitmap(Bitmap.load(file));
	}

	public ~this()
	{
		dispose();
	}

	/// Creates a width x height texture containing the pixel data in RGBA ubyte format.
	public void create(uint width, uint height, void[] pixels)
	{
		create(width, height, GL_RGBA, pixels);
	}

	/// Creates a width x height texture containing the pixel data using ubytes.
	public void create(uint width, uint height, int mode, void[] pixels)
	{
		glGenTextures(1, &_id);
		glBindTexture(GL_TEXTURE_2D, _id);

		glTexImage2D(GL_TEXTURE_2D, 0, mode, width, height, 0, mode, GL_UNSIGNED_BYTE, pixels.ptr);

		applyParameters();

		this.inMode = mode;
		this.mode	= mode;
		_width		= width;
		_height		= height;

		if (!valid)
			throw new Exception("OpenGL ErrorCode " ~ to!string(glGetError()));
	}

	///
	public void create(uint width, uint height, int inMode, int mode, void[] pixels, int type = GL_UNSIGNED_BYTE)
	{
		glGenTextures(1, &_id);
		glBindTexture(GL_TEXTURE_2D, _id);

		glTexImage2D(GL_TEXTURE_2D, 0, inMode, width, height, 0, mode, type, pixels.ptr);

		applyParameters();

		this.inMode = inMode;
		this.mode	= mode;
		_width		= width;
		_height		= height;

		if (!valid)
			throw new Exception("OpenGL ErrorCode " ~ to!string(glGetError()));
	}

	/// Use this when changing filter or wrap after creating the texture.
	/// Calls automatically after `create`.
	public void applyParameters()
	{
		bind(0);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, magFilter);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, minFilter);

		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, wrapX);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, wrapY);

		if (enableMipMaps)
		{
			glGenerateMipmap(GL_TEXTURE_2D);
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY_EXT, 16);
		}
	}

	/// Binds the current texture to the given unit.
	public void bind(uint unit)
	{
		glActiveTexture(GL_TEXTURE0 + unit);
		glBindTexture(GL_TEXTURE_2D, _id);
	}

	/// Creates the texture from a bitmap.
	public void fromBitmap(Bitmap bitmap, string name = "Bitmap")
	{
		if (!bitmap.valid)
			throw new Exception(name ~ " is invalid!");

		int mode = GL_RGB;

		if (bitmap.surface.format.BytesPerPixel == 4)
		{
			mode = GL_RGBA;
		}

		create(bitmap.width, bitmap.height, mode, bitmap.surface.pixels[0 .. bitmap.width * bitmap.height * bitmap.surface.format.BytesPerPixel]);
	}

	/// Resizes the texture containing the new data.
	public void resize(uint width, uint height, void[] pixels = null)
	{
		bind(0);
		glTexImage2D(GL_TEXTURE_2D, 0, inMode, width, height, 0, mode, GL_UNSIGNED_BYTE, pixels.ptr);
		_width	= width;
		_height = height;
	}

	///
	public void dispose()
	{
		if (valid)
			glDeleteTextures(1, &_id);
	}

	///
	public @property bool valid()
	{
		return _id > 0;
	}
}
