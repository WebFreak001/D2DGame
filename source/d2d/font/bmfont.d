module d2d.font.bmfont;
version (BindSDL_Image)  : import d2d;

import std.algorithm : max;
import std.utf : byDchar;
import std.path : buildPath;

import BM = bmfont;
import fs = std.file;

/// Implementation for AngelCode BMFont.
class BMFont : IFont
{
private:
	BM.Font _handle = void;
	Texture[] _textures;
	string _textureFolder;

public:
	 ~this()
	{
	}

	/// Creates a new BMFont instance with a textureFolder used as base path for texture loading
	this(string textureFolder)
	{
		_textureFolder = textureFolder;
	}

	/// Handle to underlying `bmfont.Font` handle.
	@property ref BM.Font handle()
	{
		return _handle;
	}

	/// All textures in the BMFont file
	@property ref Texture[] textures()
	{
		return _textures;
	}

	/// Loads the font from a binary or text bmfont file.
	override void load(string file, int sizeInPt)
	{
		_handle = BM.parseFnt(cast(ubyte[]) fs.read(file));
		foreach (page; _handle.pages)
			textures ~= new Texture(buildPath(_textureFolder, page));
	}

	/// Returns true if font has been loaded.
	override @property bool valid()
	{
		return _handle.type != 0;
	}

	override void dispose()
	{
	}

	/// Renders a string to an IText.
	override IText render(string text, float scale = 1.0f)
	{
		BMText ret = new BMText(this);
		ret.text = text;
		ret.scale = scale;
		return ret;
	}

	/// Renders a multiline string to an IText.
	override IText renderMultiline(string text, float scale = 1.0f)
	{
		BMText ret = new BMText(this);
		ret.text = text;
		ret.scale = scale;
		ret.multiline = true;
		return ret;
	}

	/// Returns the line height of this font.
	@property float lineHeight()
	{
		return cast(float) _handle.common.lineHeight;
	}

	/// Returns the dimensions of a string with this font.
	override vec2 measureText(string text, float scale = 1.0f)
	{
		if (!text.length)
			return vec2(0, 0);
		int w, h;
		dchar last;
		foreach (c; text.byDchar)
		{
			auto bmChar = _handle.getChar(c);
			w += bmChar.xadvance;
			h = max(h, bmChar.yoffset + bmChar.height);
			if (last != dchar.init)
				w += _handle.getKerning(last, c);
			last = c;
		}
		auto lastBmChar = _handle.getChar(last);
		w = w - lastBmChar.xadvance + lastBmChar.xoffset + lastBmChar.width;
		return vec2(w * scale, h * scale);
	}

	/// Returns the dimensions of a multiline string with this font.
	override vec2 measureTextMultiline(string text, float scale = 1.0f)
	{
		string[] lines = text.split('\n');
		int w;
		foreach (string line; lines)
		{
			vec2 size = measureText(line);
			w = max(w, cast(int) size.x);
		}
		return vec2(w * scale,
				((lines.length - 1) * _handle.common.lineHeight + measureText(lines[$ - 1]).y) * scale);
	}
}
