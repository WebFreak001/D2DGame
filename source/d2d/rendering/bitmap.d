module d2d.rendering.bitmap;

import d2d;

/// Thin wrap around SDL_Surface including loading [png, webp, tiff, bmp] using SDL_Image.
class Bitmap : IVerifiable, IDisposable
{
	private SDL_Surface* _handle;

	/// Handle to the `SDL_Surface*`.
	public @property SDL_Surface* surface()
	{
		return _handle;
	}

	/// Checks if the handle is not null.
	public @property bool valid()
	{
		return _handle !is null;
	}

	/// Width of this bitmap. Returns 0 if invalid.
	public @property int width()
	{
		if (!valid)
			return 0;
		return _handle.w;
	}

	/// Height of this bitmap. Returns 0 if invalid.
	public @property int height()
	{
		if (!valid)
			return 0;
		return _handle.h;
	}

	private this(SDL_Surface * surface)
	{
		_handle = surface;
	}

	/// Creates a new width x height bitmap with a specified bit depth.
	public this(int width, int height, int depth = 24, int redChannel = 0, int greenChannel = 0, int blueChannel = 0, int alphaChannel = 0)
	{
		_handle = SDL_CreateRGBSurface(0, width, height, depth, redChannel, greenChannel, blueChannel, alphaChannel);
	}

	public ~this()
	{
		dispose();
	}

	/// Creates a new width x height bitmap with a specified bit depth containing pixel data.
	public this(void[] pixels, int width, int height, int depth = 24, int redChannel = 0, int greenChannel = 0, int blueChannel = 0, int alphaChannel = 0)
	{
		_handle = SDL_CreateRGBSurfaceFrom(pixels.ptr, width, height, depth, width * (depth >> 3), redChannel, greenChannel, blueChannel, alphaChannel);
	}

	/// Creates a bitmap from a `SDL_Surface*`.
	public static Bitmap fromSurface(SDL_Surface* surface)
	{
		return new Bitmap(surface);
	}

	/// Loads a png/webp/tiff/bmp from a file on the filesystem.
	version (BindSDL_Image) public static Bitmap load(string file)
	{
		Bitmap bmp = new Bitmap(IMG_Load(file.toStringz()));

		if (!bmp.valid)
			throw new Exception(cast(string) IMG_GetError().fromStringz());

		return bmp;
	}

	/// Deallocates the memory and invalidates `this`.
	public void dispose()
	{
		if (valid)
		{
			SDL_FreeSurface(_handle);
			_handle = null;
		}
	}

	/// Saves the bitmap to a .bmp file.
	public void save(string file)
	{
		SDL_SaveBMP(_handle, file.toStringz());
	}

	/// Copies the bitmap and creates a new bitmap in the given pixelformat.
	public Bitmap convert(const SDL_PixelFormat* format)
	{
		return new Bitmap(SDL_ConvertSurface(_handle, format, 0));
	}

	/// Gets the rgb hex from the color based on the bitmap format.
	public uint mapRGB(Color color)
	{
		return SDL_MapRGB(_handle.format, color.R, color.G, color.B);
	}

	/// Gets the rgb hex from the color based on the bitmap format.
	public uint mapRGBA(ubyte r, ubyte g, ubyte b, ubyte a)
	{
		return SDL_MapRGBA(_handle.format, r, g, b, a);
	}

	/// Fills the entire bitmap with one color.
	public void fill(Color color)
	{
		SDL_FillRect(_handle, null, mapRGB(color));
	}

	/// Fills a rectangle with one color.
	public void fill(int x, int y, int width, int height, Color color)
	{
		SDL_FillRect(_handle, new SDL_Rect(x, y, width, height), mapRGB(color));
	}

	/// Gets the RGB color at position x, y. (0, 0) is top left.
	public Color getPixel(int x, int y)
	{
		ubyte r, g, b;
		SDL_GetRGB((cast(uint*) _handle.pixels)[x + y * width], _handle.format, &r, &g, &b);
		return Color(r, g, b);
	}

	/// Gets the RGBA color at position x, y as R, G, B, A ubyte array. (0, 0) is top left.
	public ubyte[] getPixelRGBA(int x, int y)
	{
		ubyte r, g, b, a;
		SDL_GetRGBA((cast(uint*) _handle.pixels)[x + y * width], _handle.format, &r, &g, &b, &a);
		return [r, g, b, a];
	}

	/// Sets the RGB color at position x, y. (0, 0) is top left.
	public void setPixel(int x, int y, Color color)
	{
		(cast(uint*) _handle.pixels)[x + y * width] = mapRGB(color);
	}

	/// Sets the RGBA color at position x, y. (0, 0) is top left.
	public void setPixelRGBA(int x, int y, ubyte r, ubyte g, ubyte b, ubyte a)
	{
		(cast(uint*) _handle.pixels)[x + y * width] = mapRGBA(r, g, b, a);
	}
}
