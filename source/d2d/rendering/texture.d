module d2d.rendering.texture;

import d2d;

import std.conv : to;

/// Texture filter mode for min and mag filters.
enum TextureFilterMode : int
{
	Linear               = GL_LINEAR,                 /// `GL_LINEAR` sampling. Smooth looking textures.
	Nearest              = GL_NEAREST,                /// `GL_NEAREST` sampling. No smoothing.
	NearestMipmapNearest = GL_NEAREST_MIPMAP_NEAREST, /// `GL_NEAREST_MIPMAP_NEAREST` sampling. Not usable in mag filter.
	LinearMipmapNearest  = GL_LINEAR_MIPMAP_NEAREST,  /// `GL_LINEAR_MIPMAP_NEAREST` sampling. Not usable in mag filter.
	NearestMipmapLinear  = GL_NEAREST_MIPMAP_LINEAR,  /// `GL_NEAREST_MIPMAP_LINEAR` sampling. Not usable in mag filter.
	LinearMipmapLinear   = GL_LINEAR_MIPMAP_LINEAR,   /// `GL_LINEAR_MIPMAP_LINEAR` sampling. Not usable in mag filter.
}

/// Texture clamp mode for wrap x, wrap y, wrap z.
enum TextureClampMode : int
{
	ClampToBorder = GL_CLAMP_TO_BORDER, /// Clamps the texture coordinate at the border. Will include a border.
	ClampToEdge   = GL_CLAMP_TO_EDGE,   /// Clamps the texture coordinate at the edge of the texture.
	Repeat        = GL_REPEAT,          /// Repeats the texture coordinate when being larger than 1.
	Mirror        = GL_MIRRORED_REPEAT  /// Repeats the texture coordinate and mirrors every time for better tiling.
}

/// Texture for drawing using OpenGL.
class Texture : IDisposable, IVerifiable
{
	/// Enable mipmaps. Disabled by default.
	public bool enableMipMaps = false;

	/// Min Filter for this texture.
	/// Needs to call Texture.applyParameters when called after creation.
	public TextureFilterMode minFilter = TextureFilterMode.Linear;

	/// Mag Filter for this texture.
	/// Needs to call Texture.applyParameters when called after creation.
	public TextureFilterMode magFilter = TextureFilterMode.Linear;

	/// Wrap x for this texture.
	/// Needs to call Texture.applyParameters when called after creation.
	public TextureClampMode wrapX = TextureClampMode.Repeat;

	/// Wrap y Filter for this texture.
	/// Needs to call Texture.applyParameters when called after creation.
	public TextureClampMode wrapY = TextureClampMode.Repeat;

	private int inMode, mode;
	private uint _id;
	private uint _width, _height;

	/// OpenGL id of this texture.
	/// id == 0 when not created.
	public @property uint id()
	{
		return _id;
	}

	/// Width of this texture.
	/// width == 0 when not created.
	public @property uint width()
	{
		return _width;
	}

	/// Height of this texture.
	/// height == 0 when not created.
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
	public static bool supportsAnisotropy;

	public static void load()
	{
		_white = new Texture();
		_white.create(1, 1, cast(ubyte[])[255, 255, 255, 255]);
	}

	/// Only allocates memory for the instance but does not create anything.
	public this() {}

	/// Creates and loads the texture with the given filters.
	version (BindSDL_Image) public this(string file, TextureFilterMode min = TextureFilterMode.Linear, TextureFilterMode mag = TextureFilterMode.Linear, TextureClampMode wrapX = TextureClampMode.Repeat, TextureClampMode wrapY = TextureClampMode.Repeat)
	{
		if (min == TextureFilterMode.LinearMipmapLinear || min == TextureFilterMode.LinearMipmapNearest)
			enableMipMaps = true;
		minFilter = min;
		magFilter = mag;
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

	/// Recreates a width x height texture containing the pixel data in RGBA ubyte format without disposing the old one.
	public void recreate(uint width, uint height, void[] pixels)
	{
		recreate(width, height, GL_RGBA, pixels);
	}

	/// Creates a width x height texture containing the pixel data using ubytes.
	public void create(uint width, uint height, int mode, void[] pixels)
	{
		glGenTextures(1, &_id);
		glBindTexture(GL_TEXTURE_2D, _id);

		glTexImage2D(GL_TEXTURE_2D, 0, mode, width, height, 0, mode, GL_UNSIGNED_BYTE, pixels.ptr);

		applyParameters();

		this.inMode = mode;
		this.mode = mode;
		_width = width;
		_height = height;

		if (!valid)
			throw new Exception("OpenGL ErrorCode " ~ to!string(glGetError()));
	}

	/// Recreates a width x height texture containing the pixel data using ubytes without disposing the old one.
	public void recreate(uint width, uint height, int mode, void[] pixels)
	{
		bind(0);
		glTexImage2D(GL_TEXTURE_2D, 0, mode, width, height, 0, mode, GL_UNSIGNED_BYTE, pixels.ptr);

		applyParameters();

		this.inMode = mode;
		this.mode = mode;
		_width = width;
		_height = height;

		if (!valid)
			throw new Exception("OpenGL ErrorCode " ~ to!string(glGetError()));
	}

	/// Creates a width x height texture containing the pixel data in `inMode` format using `type` as array type and internally convertes to `mode`.
	public void create(uint width, uint height, int inMode, int mode, void[] pixels, int type = GL_UNSIGNED_BYTE)
	{
		glGenTextures(1, &_id);
		glBindTexture(GL_TEXTURE_2D, _id);

		glTexImage2D(GL_TEXTURE_2D, 0, inMode, width, height, 0, mode, type, pixels.ptr);

		applyParameters();

		this.inMode = inMode;
		this.mode = mode;
		_width = width;
		_height = height;

		if (!valid)
			throw new Exception("OpenGL ErrorCode " ~ to!string(glGetError()));
	}

	/// Recreates a width x height texture containing the pixel data in `inMode` format using `type` as array type and internally convertes to `mode` without disposing the old one.
	public void recreate(uint width, uint height, int inMode, int mode, void[] pixels, int type = GL_UNSIGNED_BYTE)
	{
		bind(0);
		glTexImage2D(GL_TEXTURE_2D, 0, inMode, width, height, 0, mode, type, pixels.ptr);

		applyParameters();

		this.inMode = inMode;
		this.mode = mode;
		_width = width;
		_height = height;

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
			if (supportsAnisotropy)
				glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_ANISOTROPY, 16);
		}
	}

	/// Binds the current texture to the given unit.
	public void bind(uint unit = 0)
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

	/// Creates the texture from a bitmap without disposing the old one.
	public void recreateFromBitmap(Bitmap bitmap, string name = "Bitmap")
	{
		if (!bitmap.valid)
			throw new Exception(name ~ " is invalid!");

		int mode = GL_RGB;

		if (bitmap.surface.format.BytesPerPixel == 4)
		{
			mode = GL_RGBA;
		}

		recreate(bitmap.width, bitmap.height, mode, bitmap.surface.pixels[0 .. bitmap.width * bitmap.height * bitmap.surface.format.BytesPerPixel]);
	}

	/// Resizes the texture containing the new data.
	public void resize(uint width, uint height, void[] pixels = null)
	{
		bind(0);
		glTexImage2D(GL_TEXTURE_2D, 0, inMode, width, height, 0, mode, GL_UNSIGNED_BYTE, pixels.ptr);
		_width = width;
		_height = height;
	}

	/// Deletes the texture and invalidates `this`.
	public void dispose()
	{
		if (valid)
		{
			glDeleteTextures(1, &_id);
			_id = 0;
		}
	}

	/// Checks if Texture.id is more than 0.
	public @property bool valid()
	{
		return _id > 0;
	}
}
