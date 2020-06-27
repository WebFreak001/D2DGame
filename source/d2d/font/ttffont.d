module d2d.font.ttffont;

version(BindSDL_TTF):

import d2d;

import std.algorithm : max;

/// Implementation for SDL_ttf.
class TTFFont : IFont
{
private:
	TTF_Font* _handle;

public:
	~this()
	{
		dispose();
	}

	/// Handle to underlying `TTF_Font*` handle.
	@property TTF_Font* handle()
	{
		return _handle;
	}

	/// Loads the font from a file.
	override void load(string file, int sizeInPt)
	{
		_handle = TTF_OpenFont(file.toStringz(), sizeInPt);
		if (!valid)
			throw new Exception(cast(string) TTF_GetError().fromStringz());
	}

	/// Returns if `_handle` is not `null`.
	override @property bool valid()
	{
		return _handle !is null;
	}

	/// Deallocates memory and invalidates this.
	override void dispose()
	{
		if (valid)
		{
			TTF_CloseFont(_handle);
			_handle = null;
		}
	}

	/// Renders a string to an IText.
	override IText render(string text, float scale = 1.0f)
	{
		TTFText ret = new TTFText(this);
		ret.text = text;
		ret.scale = scale;
		return ret;
	}

	/// Renders a multiline string to an IText.
	override IText renderMultiline(string text, float scale = 1.0f)
	{
		TTFText ret = new TTFText(this);
		ret.text = text;
		ret.scale = scale;
		ret.multiline = true;
		return ret;
	}

	/// Returns the line height of this font.
	@property float lineHeight()
	{
		return TTF_FontHeight(_handle);
	}

	/// Returns the dimensions of a string with this font.
	override vec2 measureText(string text, float scale = 1.0f)
	{
		int w, h;
		TTF_SizeUTF8(_handle, text.toStringz(), &w, &h);
		return vec2(w * scale, h * scale);
	}

	/// Returns the dimensions of a multiline string with this font.
	override vec2 measureTextMultiline(string text, float scale = 1.0f)
	{
		string[] lines = text.split('\n');
		int w, h;
		foreach (string line; lines)
		{
			int lw, lh;
			TTF_SizeText(_handle, line.toStringz(), &lw, &lh);
			w = max(w, lw);
			h += lh;
		}
		return vec2(w * scale, h * scale);
	}
}
