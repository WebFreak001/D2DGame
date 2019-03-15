module d2d.font.ttftext;

version(BindSDL_TTF):

import d2d;

import std.algorithm : max;

/// Implementation containing text drawable functions using a TTF font. Nice for static texts, slow for dynamic texts.
class TTFText : RectangleShape, IText
{
private:
	float _scale = 1.0f;
	string _text = "";
	TTFFont _font;
	bool _multiline = false;

public:
	/// Creates an empty ttf text
	this(TTFFont font)
	{
		_font = font;
		texture = new Texture();
		texture.create(0, 0, []);
	}

	/// Gets the scale in percent.
	override @property float scale()
	{
		return _scale;
	}

	/// Sets the scale in percent.
	override @property void scale(float value)
	{
		_scale = value;
	}

	/// Gets the text.
	override @property string text()
	{
		return _text;
	}

	/// Modifies the text.
	override @property void text(string value)
	{
		if (_text != value)
		{
			_text = value;
			redraw();
		}
	}

	/// Returns if this text should be rendered multiline.
	@property bool multiline()
	{
		return _multiline;
	}

	/// Sets if this text should be rendered multiline.
	@property void multiline(bool value)
	{
		if (_multiline != value)
		{
			_multiline = value;
			redraw();
		}
	}

	/// Should get called automatically when something changed.
	void redraw()
	{
		Bitmap bmp;
		if (_multiline)
		{
			string[] lines = text.split('\n');
			int maxWidth = 0;
			foreach (string line; lines)
			{
				int w, h;
				TTF_SizeText(_font.handle, line.toStringz(), &w, &h);
				maxWidth = max(w, maxWidth);
			}
			bmp = Bitmap.fromSurface(TTF_RenderUTF8_Blended_Wrapped(_font.handle, text.toStringz(), Color.White.sdl_color, maxWidth));
		}
		else
		{
			bmp = Bitmap.fromSurface(TTF_RenderUTF8_Blended(_font.handle, text.toStringz(), Color.White.sdl_color));
		}
		if (!bmp.valid)
			throw new Exception(cast(string) TTF_GetError().fromStringz());
		texture.recreateFromBitmap(bmp, "Blended Text: \"" ~ text ~ "\"");
		size = vec2(texture.width, texture.height);
		create();
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		matrixStack.push();
		matrixStack.top = matrixStack.top * mat4.scaling(_scale, _scale, 1);
		super.draw(target, shader);
		matrixStack.pop();
	}

	override @property bool valid()
	{
		return super.valid;
	}

	override void dispose()
	{
		super.dispose();
	}
}
