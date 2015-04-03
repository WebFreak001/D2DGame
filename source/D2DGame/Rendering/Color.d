module D2DGame.Rendering.Color;

import D2D;

struct Color
{
	public static const Color AliceBlue			   = Color.fromRGB(0xF0F8FF);
	public static const Color AntiqueWhite		   = Color.fromRGB(0xFAEBD7);
	public static const Color Aqua				   = Color.fromRGB(0x00FFFF);
	public static const Color Aquamarine		   = Color.fromRGB(0x7FFFD4);
	public static const Color Azure				   = Color.fromRGB(0xF0FFFF);
	public static const Color Beige				   = Color.fromRGB(0xF5F5DC);
	public static const Color Bisque			   = Color.fromRGB(0xFFE4C4);
	public static const Color Black				   = Color.fromRGB(0x000000);
	public static const Color BlanchedAlmond	   = Color.fromRGB(0xFFEBCD);
	public static const Color Blue				   = Color.fromRGB(0x0000FF);
	public static const Color BlueViolet		   = Color.fromRGB(0x8A2BE2);
	public static const Color Brown				   = Color.fromRGB(0xA52A2A);
	public static const Color BurlyWood			   = Color.fromRGB(0xDEB887);
	public static const Color CadetBlue			   = Color.fromRGB(0x5F9EA0);
	public static const Color Chartreuse		   = Color.fromRGB(0x7FFF00);
	public static const Color Chocolate			   = Color.fromRGB(0xD2691E);
	public static const Color Coral				   = Color.fromRGB(0xFF7F50);
	public static const Color CornflowerBlue	   = Color.fromRGB(0x6495ED);
	public static const Color Cornsilk			   = Color.fromRGB(0xFFF8DC);
	public static const Color Crimson			   = Color.fromRGB(0xDC143C);
	public static const Color Cyan				   = Color.fromRGB(0x00FFFF);
	public static const Color DarkBlue			   = Color.fromRGB(0x00008B);
	public static const Color DarkCyan			   = Color.fromRGB(0x008B8B);
	public static const Color DarkGoldenRod		   = Color.fromRGB(0xB8860B);
	public static const Color DarkGray			   = Color.fromRGB(0xA9A9A9);
	public static const Color DarkGreen			   = Color.fromRGB(0x006400);
	public static const Color DarkKhaki			   = Color.fromRGB(0xBDB76B);
	public static const Color DarkMagenta		   = Color.fromRGB(0x8B008B);
	public static const Color DarkOliveGreen	   = Color.fromRGB(0x556B2F);
	public static const Color DarkOrange		   = Color.fromRGB(0xFF8C00);
	public static const Color DarkOrchid		   = Color.fromRGB(0x9932CC);
	public static const Color DarkRed			   = Color.fromRGB(0x8B0000);
	public static const Color DarkSalmon		   = Color.fromRGB(0xE9967A);
	public static const Color DarkSeaGreen		   = Color.fromRGB(0x8FBC8F);
	public static const Color DarkSlateBlue		   = Color.fromRGB(0x483D8B);
	public static const Color DarkSlateGray		   = Color.fromRGB(0x2F4F4F);
	public static const Color DarkTurquoise		   = Color.fromRGB(0x00CED1);
	public static const Color DarkViolet		   = Color.fromRGB(0x9400D3);
	public static const Color DeepPink			   = Color.fromRGB(0xFF1493);
	public static const Color DeepSkyBlue		   = Color.fromRGB(0x00BFFF);
	public static const Color DimGray			   = Color.fromRGB(0x696969);
	public static const Color DodgerBlue		   = Color.fromRGB(0x1E90FF);
	public static const Color FireBrick			   = Color.fromRGB(0xB22222);
	public static const Color FloralWhite		   = Color.fromRGB(0xFFFAF0);
	public static const Color ForestGreen		   = Color.fromRGB(0x228B22);
	public static const Color Fuchsia			   = Color.fromRGB(0xFF00FF);
	public static const Color Gainsboro			   = Color.fromRGB(0xDCDCDC);
	public static const Color GhostWhite		   = Color.fromRGB(0xF8F8FF);
	public static const Color Gold				   = Color.fromRGB(0xFFD700);
	public static const Color GoldenRod			   = Color.fromRGB(0xDAA520);
	public static const Color Gray				   = Color.fromRGB(0x808080);
	public static const Color Green				   = Color.fromRGB(0x008000);
	public static const Color GreenYellow		   = Color.fromRGB(0xADFF2F);
	public static const Color HoneyDew			   = Color.fromRGB(0xF0FFF0);
	public static const Color HotPink			   = Color.fromRGB(0xFF69B4);
	public static const Color IndianRed			   = Color.fromRGB(0xCD5C5C);
	public static const Color Indigo			   = Color.fromRGB(0x4B0082);
	public static const Color Ivory				   = Color.fromRGB(0xFFFFF0);
	public static const Color Khaki				   = Color.fromRGB(0xF0E68C);
	public static const Color Lavender			   = Color.fromRGB(0xE6E6FA);
	public static const Color LavenderBlush		   = Color.fromRGB(0xFFF0F5);
	public static const Color LawnGreen			   = Color.fromRGB(0x7CFC00);
	public static const Color LemonChiffon		   = Color.fromRGB(0xFFFACD);
	public static const Color LightBlue			   = Color.fromRGB(0xADD8E6);
	public static const Color LightCoral		   = Color.fromRGB(0xF08080);
	public static const Color LightCyan			   = Color.fromRGB(0xE0FFFF);
	public static const Color LightGoldenRodYellow = Color.fromRGB(0xFAFAD2);
	public static const Color LightGray			   = Color.fromRGB(0xD3D3D3);
	public static const Color LightGreen		   = Color.fromRGB(0x90EE90);
	public static const Color LightPink			   = Color.fromRGB(0xFFB6C1);
	public static const Color LightSalmon		   = Color.fromRGB(0xFFA07A);
	public static const Color LightSeaGreen		   = Color.fromRGB(0x20B2AA);
	public static const Color LightSkyBlue		   = Color.fromRGB(0x87CEFA);
	public static const Color LightSlateGray	   = Color.fromRGB(0x778899);
	public static const Color LightSteelBlue	   = Color.fromRGB(0xB0C4DE);
	public static const Color LightYellow		   = Color.fromRGB(0xFFFFE0);
	public static const Color Lime				   = Color.fromRGB(0x00FF00);
	public static const Color LimeGreen			   = Color.fromRGB(0x32CD32);
	public static const Color Linen				   = Color.fromRGB(0xFAF0E6);
	public static const Color Magenta			   = Color.fromRGB(0xFF00FF);
	public static const Color Maroon			   = Color.fromRGB(0x800000);
	public static const Color MediumAquaMarine	   = Color.fromRGB(0x66CDAA);
	public static const Color MediumBlue		   = Color.fromRGB(0x0000CD);
	public static const Color MediumOrchid		   = Color.fromRGB(0xBA55D3);
	public static const Color MediumPurple		   = Color.fromRGB(0x9370DB);
	public static const Color MediumSeaGreen	   = Color.fromRGB(0x3CB371);
	public static const Color MediumSlateBlue	   = Color.fromRGB(0x7B68EE);
	public static const Color MediumSpringGreen	   = Color.fromRGB(0x00FA9A);
	public static const Color MediumTurquoise	   = Color.fromRGB(0x48D1CC);
	public static const Color MediumVioletRed	   = Color.fromRGB(0xC71585);
	public static const Color MidnightBlue		   = Color.fromRGB(0x191970);
	public static const Color MintCream			   = Color.fromRGB(0xF5FFFA);
	public static const Color MistyRose			   = Color.fromRGB(0xFFE4E1);
	public static const Color Moccasin			   = Color.fromRGB(0xFFE4B5);
	public static const Color NavajoWhite		   = Color.fromRGB(0xFFDEAD);
	public static const Color Navy				   = Color.fromRGB(0x000080);
	public static const Color OldLace			   = Color.fromRGB(0xFDF5E6);
	public static const Color Olive				   = Color.fromRGB(0x808000);
	public static const Color OliveDrab			   = Color.fromRGB(0x6B8E23);
	public static const Color Orange			   = Color.fromRGB(0xFFA500);
	public static const Color OrangeRed			   = Color.fromRGB(0xFF4500);
	public static const Color Orchid			   = Color.fromRGB(0xDA70D6);
	public static const Color PaleGoldenRod		   = Color.fromRGB(0xEEE8AA);
	public static const Color PaleGreen			   = Color.fromRGB(0x98FB98);
	public static const Color PaleTurquoise		   = Color.fromRGB(0xAFEEEE);
	public static const Color PaleVioletRed		   = Color.fromRGB(0xDB7093);
	public static const Color PapayaWhip		   = Color.fromRGB(0xFFEFD5);
	public static const Color PeachPuff			   = Color.fromRGB(0xFFDAB9);
	public static const Color Peru				   = Color.fromRGB(0xCD853F);
	public static const Color Pink				   = Color.fromRGB(0xFFC0CB);
	public static const Color Plum				   = Color.fromRGB(0xDDA0DD);
	public static const Color PowderBlue		   = Color.fromRGB(0xB0E0E6);
	public static const Color Purple			   = Color.fromRGB(0x800080);
	public static const Color RebeccaPurple		   = Color.fromRGB(0x663399);
	public static const Color Red				   = Color.fromRGB(0xFF0000);
	public static const Color RosyBrown			   = Color.fromRGB(0xBC8F8F);
	public static const Color RoyalBlue			   = Color.fromRGB(0x4169E1);
	public static const Color SaddleBrown		   = Color.fromRGB(0x8B4513);
	public static const Color Salmon			   = Color.fromRGB(0xFA8072);
	public static const Color SandyBrown		   = Color.fromRGB(0xF4A460);
	public static const Color SeaGreen			   = Color.fromRGB(0x2E8B57);
	public static const Color SeaShell			   = Color.fromRGB(0xFFF5EE);
	public static const Color Sienna			   = Color.fromRGB(0xA0522D);
	public static const Color Silver			   = Color.fromRGB(0xC0C0C0);
	public static const Color SkyBlue			   = Color.fromRGB(0x87CEEB);
	public static const Color SlateBlue			   = Color.fromRGB(0x6A5ACD);
	public static const Color SlateGray			   = Color.fromRGB(0x708090);
	public static const Color Snow				   = Color.fromRGB(0xFFFAFA);
	public static const Color SpringGreen		   = Color.fromRGB(0x00FF7F);
	public static const Color SteelBlue			   = Color.fromRGB(0x4682B4);
	public static const Color Tan				   = Color.fromRGB(0xD2B48C);
	public static const Color Teal				   = Color.fromRGB(0x008080);
	public static const Color Thistle			   = Color.fromRGB(0xD8BFD8);
	public static const Color Tomato			   = Color.fromRGB(0xFF6347);
	public static const Color Turquoise			   = Color.fromRGB(0x40E0D0);
	public static const Color Violet			   = Color.fromRGB(0xEE82EE);
	public static const Color Wheat				   = Color.fromRGB(0xF5DEB3);
	public static const Color White				   = Color.fromRGB(0xFFFFFF);
	public static const Color WhiteSmoke		   = Color.fromRGB(0xF5F5F5);
	public static const Color Yellow			   = Color.fromRGB(0xFFFF00);
	public static const Color YellowGreen		   = Color.fromRGB(0x9ACD32);

	public this(ubyte r, ubyte g, ubyte b)
	{
		_r = r;
		_g = g;
		_b = b;
	}

	deprecated ("Use fromRGB instead")
	public static Color fromHex(const int hex)
	{
		return Color((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF);
	}

	public static Color fromRGB(const int hex)
	{
		return Color((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF);
	}

	public static Color fromBGR(const int hex)
	{
		return Color(hex & 0xFF, (hex >> 8) & 0xFF, (hex >> 16) & 0xFF);
	}

	/// <summary>
	/// Converts from HSL to RGB
	/// <param name="hue">Hue in range 0 - 1</param>
	/// <param name="saturation">Saturation in range 0 - 1</param>
	/// <param name="lightness">Lightness in range 0 - 1</param>
	/// </summary>
	public void fromHSL(double hue, double saturation, double lightness)
	{
		double v = lightness <= 0.5 ? (lightness * (1 + saturation)) : (1 + saturation - lightness * saturation);
		double r, g, b;
		r = g = b = 1;

		if (v > 0)
		{
			double m;
			double sv;
			int	   sextant;
			double fract, vsf, mid1, mid2;

			m		= lightness + lightness - v;
			sv		= (v - m) / v;
			hue	   *= 6.0;
			sextant = cast(int) hue;
			fract	= hue - sextant;
			vsf		= v * sv * fract;
			mid1	= m + vsf;
			mid2	= v - vsf;
			switch (sextant)
			{
			case 0:
				r = v;
				g = mid1;
				b = m;
				break;
			case 1:
				r = mid2;
				g = v;
				b = m;
				break;
			case 2:
				r = m;
				g = v;
				b = mid1;
				break;
			case 3:
				r = m;
				g = mid2;
				b = v;
				break;
			case 4:
				r = mid1;
				g = m;
				b = v;
				break;
			case 5:
				r = v;
				g = m;
				b = mid2;
				break;
			default:
				break;
			}
		}
		_r = cast(ubyte) (r * 255);
		_g = cast(ubyte) (g * 255);
		_b = cast(ubyte) (b * 255);
	}

	public override bool opEquals()(auto ref const Color color) const
	{
		return _r == color._r && _g == color._g && _b == color._b;
	}

	public @property SDL_Color sdl_color()
	{
		return SDL_Color(_r, _g, _b, 255);
	}

	public @property ref ubyte R()
	{
		return _r;
	}
	public @property ref ubyte G()
	{
		return _g;
	}
	public @property ref ubyte B()
	{
		return _b;
	}

	public @property float fR()
	{
		return _r * 0.00392156862f;
	}
	public @property float fG()
	{
		return _g * 0.00392156862f;
	}
	public @property float fB()
	{
		return _b * 0.00392156862f;
	}

	public @property vec3 f()
	{
		return vec3(fR, fG, fB);
	}

	public @property int RGB()
	{
		return _r << 16 | _g << 8 | _b;
	}
	public @property int BGR()
	{
		return _r | _g << 8 | _b << 16;
	}

	private ubyte _r, _g, _b;
}
