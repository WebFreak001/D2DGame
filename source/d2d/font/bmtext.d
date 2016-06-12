module d2d.font.bmtext;

import d2d;

import std.utf : byDchar;

/// Implementation containing text drawable functions using an AngelCode BMFont. Nice and fast for unscaled text, reduced memory usage, render time scales with text length, no re-render times, requires some additional shader uniforms.
class BMText : Transformable, IText
{
private:
	float _scale = 1.0f;
	string _text = "";
	BMFont _font;
	bool _multiline = false;
	RectangleShape unitRect;
	float iWidth, iHeight;

public:
	/// Creates an empty bmfont text
	this(BMFont font)
	{
		_font = font;
		iWidth = 1.0f / _font.handle.common.scaleW;
		iHeight = 1.0f / _font.handle.common.scaleH;
		unitRect = RectangleShape.create(vec2(0, 0), vec2(1, 1));
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
		_text = value;
	}

	/// Returns if this text should be rendered multiline.
	@property bool multiline()
	{
		return _multiline;
	}

	/// Sets if this text should be rendered multiline.
	@property void multiline(bool value)
	{
		_multiline = value;
	}

	/// Dynamically draws the text onto a target. Requires the shader to have `texRect` vec4(uvX, uvY, uvW, uvH) and `sizeRect` vec4(posX, posY, width, height) uniforms.
	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		matrixStack.push();
		matrixStack.top *= mat4.scaling(_scale, _scale, 1);
		matrixStack.top *= transform;
		int x, y;
		dchar last;
		for (int i = 0; i < _font.textures.length; i++)
			_font.textures[i].bind(i);
		if (shader)
			shader.bind();
		foreach (dc; _text.byDchar)
		{
			auto bmChar = _font.handle.getChar(dc);
			if (bmChar.id == dchar.init)
			{
				if (_multiline && dc == '\n')
				{
					x = 0;
					y += _font.handle.common.lineHeight;
				}
				continue;
			}

			shader.set("tex", cast(int) bmChar.page);
			shader.set("texRect", vec4(bmChar.x * iWidth, bmChar.y * iHeight,
					bmChar.width * iWidth, bmChar.height * iHeight));
			shader.set("sizeRect", vec4(x + bmChar.xoffset, y + bmChar.yoffset,
					bmChar.width, bmChar.height));
			unitRect.draw(target, shader);
			if (_multiline && dc == '\n')
			{
				x = 0;
				y += _font.handle.common.lineHeight;
				continue;
			}
			if (last != dchar.init)
				x += _font.handle.getKerning(last, dc);
			x += bmChar.xadvance;
			last = dc;
		}
		matrixStack.pop();
	}

	override @property bool valid()
	{
		return true;
	}

	override void dispose()
	{
	}
}
