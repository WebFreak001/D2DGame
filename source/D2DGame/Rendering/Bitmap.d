module D2DGame.Rendering.Bitmap;

import D2D;

class Bitmap
{
	private SDL_Surface* _handle;

	public @property SDL_Surface* surface()
	{
		return _handle;
	}
	public @property bool valid()
	{
		return _handle !is null;
	}

	public @property int width()
	{
		return _handle.w;
	}
	public @property int height()
	{
		return _handle.h;
	}

	private this(SDL_Surface * surface)
	{
		_handle = surface;
	}

	public this(int width, int height, int depth)
	{
		_handle = SDL_CreateRGBSurface(0, width, height, depth, 0, 0, 0, 0);
	}

	public ~this()
	{
		destroy();
	}

	public this(void[] pixels, int width, int height, int depth)
	{
		_handle = SDL_CreateRGBSurfaceFrom(pixels.ptr, width, height, depth, width * (depth >> 3), 0, 0, 0, 0);
	}

	public static Bitmap fromSurface(SDL_Surface* surface)
	{
		return new Bitmap(surface);
	}

	public static Bitmap load(string file)
	{
		Bitmap bmp = new Bitmap(IMG_Load(file.toStringz()));

		if (!bmp.valid)
			throw new Exception(cast(string) IMG_GetError().fromStringz());

		return bmp;
	}

	public void destroy()
	{
		SDL_FreeSurface(_handle);
		_handle = null;
	}

	public void save(string file)
	{
		SDL_SaveBMP(_handle, file.toStringz());
	}

	public Bitmap convert(const SDL_PixelFormat* format)
	{
		return new Bitmap(SDL_ConvertSurface(_handle, format, 0));
	}

	public uint mapRGB(Color color)
	{
		return SDL_MapRGB(_handle.format, color.R, color.G, color.B);
	}

	public void fill(Color color)
	{
		SDL_FillRect(_handle, null, mapRGB(color));
	}

	public void fill(int x, int y, int width, int height, Color color)
	{
		SDL_FillRect(_handle, new SDL_Rect(x, y, width, height), mapRGB(color));
	}

	public Color getPixel(int x, int y)
	{
		ubyte r, g, b;
		SDL_GetRGB((cast(uint*) _handle.pixels)[x + y * width], _handle.format, &r, &g, &b);
		return Color(r, g, b);
	}

	public void setPixel(int x, int y, Color color)
	{
		(cast(uint*) _handle.pixels)[x + y * width] = mapRGB(color);
	}
}
