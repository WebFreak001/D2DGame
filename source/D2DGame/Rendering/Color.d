module D2DGame.Rendering.Color;

import D2D;

/// Color structure for Bitmaps and converting HSL -> RGB and Hex -> float[3].
/// Can be converted to a `SDL_Color`.
/// Only contains RGB Colors.
struct Color
{
	/// HTML color <span style='background-color: AliceBlue'>AliceBlue</span>
	public static const Color AliceBlue = Color.fromRGB(0xF0F8FF);
	/// HTML color <span style='background-color: AntiqueWhite'>AntiqueWhite</span>
	public static const Color AntiqueWhite = Color.fromRGB(0xFAEBD7);
	/// HTML color <span style='background-color: Aqua'>Aqua</span>
	public static const Color Aqua = Color.fromRGB(0x00FFFF);
	/// HTML color <span style='background-color: Aquamarine'>Aquamarine</span>
	public static const Color Aquamarine = Color.fromRGB(0x7FFFD4);
	/// HTML color <span style='background-color: Azure'>Azure</span>
	public static const Color Azure = Color.fromRGB(0xF0FFFF);
	/// HTML color <span style='background-color: Beige'>Beige</span>
	public static const Color Beige = Color.fromRGB(0xF5F5DC);
	/// HTML color <span style='background-color: Bisque'>Bisque</span>
	public static const Color Bisque = Color.fromRGB(0xFFE4C4);
	/// HTML color <span style='background-color: Black'>Black</span>
	public static const Color Black = Color.fromRGB(0x000000);
	/// HTML color <span style='background-color: BlanchedAlmond'>BlanchedAlmond</span>
	public static const Color BlanchedAlmond = Color.fromRGB(0xFFEBCD);
	/// HTML color <span style='background-color: Blue'>Blue</span>
	public static const Color Blue = Color.fromRGB(0x0000FF);
	/// HTML color <span style='background-color: BlueViolet'>BlueViolet</span>
	public static const Color BlueViolet = Color.fromRGB(0x8A2BE2);
	/// HTML color <span style='background-color: Brown'>Brown</span>
	public static const Color Brown = Color.fromRGB(0xA52A2A);
	/// HTML color <span style='background-color: BurlyWood'>BurlyWood</span>
	public static const Color BurlyWood = Color.fromRGB(0xDEB887);
	/// HTML color <span style='background-color: CadetBlue'>CadetBlue</span>
	public static const Color CadetBlue = Color.fromRGB(0x5F9EA0);
	/// HTML color <span style='background-color: Chartreuse'>Chartreuse</span>
	public static const Color Chartreuse = Color.fromRGB(0x7FFF00);
	/// HTML color <span style='background-color: Chocolate'>Chocolate</span>
	public static const Color Chocolate = Color.fromRGB(0xD2691E);
	/// HTML color <span style='background-color: Coral'>Coral</span>
	public static const Color Coral = Color.fromRGB(0xFF7F50);
	/// HTML color <span style='background-color: CornflowerBlue'>CornflowerBlue</span>
	public static const Color CornflowerBlue = Color.fromRGB(0x6495ED);
	/// HTML color <span style='background-color: Cornsilk'>Cornsilk</span>
	public static const Color Cornsilk = Color.fromRGB(0xFFF8DC);
	/// HTML color <span style='background-color: Crimson'>Crimson</span>
	public static const Color Crimson = Color.fromRGB(0xDC143C);
	/// HTML color <span style='background-color: Cyan'>Cyan</span>
	public static const Color Cyan = Color.fromRGB(0x00FFFF);
	/// HTML color <span style='background-color: DarkBlue'>DarkBlue</span>
	public static const Color DarkBlue = Color.fromRGB(0x00008B);
	/// HTML color <span style='background-color: DarkCyan'>DarkCyan</span>
	public static const Color DarkCyan = Color.fromRGB(0x008B8B);
	/// HTML color <span style='background-color: DarkGoldenRod'>DarkGoldenRod</span>
	public static const Color DarkGoldenRod = Color.fromRGB(0xB8860B);
	/// HTML color <span style='background-color: DarkGray'>DarkGray</span>
	public static const Color DarkGray = Color.fromRGB(0xA9A9A9);
	/// HTML color <span style='background-color: DarkGreen'>DarkGreen</span>
	public static const Color DarkGreen = Color.fromRGB(0x006400);
	/// HTML color <span style='background-color: DarkKhaki'>DarkKhaki</span>
	public static const Color DarkKhaki = Color.fromRGB(0xBDB76B);
	/// HTML color <span style='background-color: DarkMagenta'>DarkMagenta</span>
	public static const Color DarkMagenta = Color.fromRGB(0x8B008B);
	/// HTML color <span style='background-color: DarkOliveGreen'>DarkOliveGreen</span>
	public static const Color DarkOliveGreen = Color.fromRGB(0x556B2F);
	/// HTML color <span style='background-color: DarkOrange'>DarkOrange</span>
	public static const Color DarkOrange = Color.fromRGB(0xFF8C00);
	/// HTML color <span style='background-color: DarkOrchid'>DarkOrchid</span>
	public static const Color DarkOrchid = Color.fromRGB(0x9932CC);
	/// HTML color <span style='background-color: DarkRed'>DarkRed</span>
	public static const Color DarkRed = Color.fromRGB(0x8B0000);
	/// HTML color <span style='background-color: DarkSalmon'>DarkSalmon</span>
	public static const Color DarkSalmon = Color.fromRGB(0xE9967A);
	/// HTML color <span style='background-color: DarkSeaGreen'>DarkSeaGreen</span>
	public static const Color DarkSeaGreen = Color.fromRGB(0x8FBC8F);
	/// HTML color <span style='background-color: DarkSlateBlue'>DarkSlateBlue</span>
	public static const Color DarkSlateBlue = Color.fromRGB(0x483D8B);
	/// HTML color <span style='background-color: DarkSlateGray'>DarkSlateGray</span>
	public static const Color DarkSlateGray = Color.fromRGB(0x2F4F4F);
	/// HTML color <span style='background-color: DarkTurquoise'>DarkTurquoise</span>
	public static const Color DarkTurquoise = Color.fromRGB(0x00CED1);
	/// HTML color <span style='background-color: DarkViolet'>DarkViolet</span>
	public static const Color DarkViolet = Color.fromRGB(0x9400D3);
	/// HTML color <span style='background-color: DeepPink'>DeepPink</span>
	public static const Color DeepPink = Color.fromRGB(0xFF1493);
	/// HTML color <span style='background-color: DeepSkyBlue'>DeepSkyBlue</span>
	public static const Color DeepSkyBlue = Color.fromRGB(0x00BFFF);
	/// HTML color <span style='background-color: DimGray'>DimGray</span>
	public static const Color DimGray = Color.fromRGB(0x696969);
	/// HTML color <span style='background-color: DodgerBlue'>DodgerBlue</span>
	public static const Color DodgerBlue = Color.fromRGB(0x1E90FF);
	/// HTML color <span style='background-color: FireBrick'>FireBrick</span>
	public static const Color FireBrick = Color.fromRGB(0xB22222);
	/// HTML color <span style='background-color: FloralWhite'>FloralWhite</span>
	public static const Color FloralWhite = Color.fromRGB(0xFFFAF0);
	/// HTML color <span style='background-color: ForestGreen'>ForestGreen</span>
	public static const Color ForestGreen = Color.fromRGB(0x228B22);
	/// HTML color <span style='background-color: Fuchsia'>Fuchsia</span>
	public static const Color Fuchsia = Color.fromRGB(0xFF00FF);
	/// HTML color <span style='background-color: Gainsboro'>Gainsboro</span>
	public static const Color Gainsboro = Color.fromRGB(0xDCDCDC);
	/// HTML color <span style='background-color: GhostWhite'>GhostWhite</span>
	public static const Color GhostWhite = Color.fromRGB(0xF8F8FF);
	/// HTML color <span style='background-color: Gold'>Gold</span>
	public static const Color Gold = Color.fromRGB(0xFFD700);
	/// HTML color <span style='background-color: GoldenRod'>GoldenRod</span>
	public static const Color GoldenRod = Color.fromRGB(0xDAA520);
	/// HTML color <span style='background-color: Gray'>Gray</span>
	public static const Color Gray = Color.fromRGB(0x808080);
	/// HTML color <span style='background-color: Green'>Green</span>
	public static const Color Green = Color.fromRGB(0x008000);
	/// HTML color <span style='background-color: GreenYellow'>GreenYellow</span>
	public static const Color GreenYellow = Color.fromRGB(0xADFF2F);
	/// HTML color <span style='background-color: HoneyDew'>HoneyDew</span>
	public static const Color HoneyDew = Color.fromRGB(0xF0FFF0);
	/// HTML color <span style='background-color: HotPink'>HotPink</span>
	public static const Color HotPink = Color.fromRGB(0xFF69B4);
	/// HTML color <span style='background-color: IndianRed'>IndianRed</span>
	public static const Color IndianRed = Color.fromRGB(0xCD5C5C);
	/// HTML color <span style='background-color: Indigo'>Indigo</span>
	public static const Color Indigo = Color.fromRGB(0x4B0082);
	/// HTML color <span style='background-color: Ivory'>Ivory</span>
	public static const Color Ivory = Color.fromRGB(0xFFFFF0);
	/// HTML color <span style='background-color: Khaki'>Khaki</span>
	public static const Color Khaki = Color.fromRGB(0xF0E68C);
	/// HTML color <span style='background-color: Lavender'>Lavender</span>
	public static const Color Lavender = Color.fromRGB(0xE6E6FA);
	/// HTML color <span style='background-color: LavenderBlush'>LavenderBlush</span>
	public static const Color LavenderBlush = Color.fromRGB(0xFFF0F5);
	/// HTML color <span style='background-color: LawnGreen'>LawnGreen</span>
	public static const Color LawnGreen = Color.fromRGB(0x7CFC00);
	/// HTML color <span style='background-color: LemonChiffon'>LemonChiffon</span>
	public static const Color LemonChiffon = Color.fromRGB(0xFFFACD);
	/// HTML color <span style='background-color: LightBlue'>LightBlue</span>
	public static const Color LightBlue = Color.fromRGB(0xADD8E6);
	/// HTML color <span style='background-color: LightCoral'>LightCoral</span>
	public static const Color LightCoral = Color.fromRGB(0xF08080);
	/// HTML color <span style='background-color: LightCyan'>LightCyan</span>
	public static const Color LightCyan = Color.fromRGB(0xE0FFFF);
	/// HTML color <span style='background-color: LightGoldenRodYellow'>LightGoldenRodYellow</span>
	public static const Color LightGoldenRodYellow = Color.fromRGB(0xFAFAD2);
	/// HTML color <span style='background-color: LightGray'>LightGray</span>
	public static const Color LightGray = Color.fromRGB(0xD3D3D3);
	/// HTML color <span style='background-color: LightGreen'>LightGreen</span>
	public static const Color LightGreen = Color.fromRGB(0x90EE90);
	/// HTML color <span style='background-color: LightPink'>LightPink</span>
	public static const Color LightPink = Color.fromRGB(0xFFB6C1);
	/// HTML color <span style='background-color: LightSalmon'>LightSalmon</span>
	public static const Color LightSalmon = Color.fromRGB(0xFFA07A);
	/// HTML color <span style='background-color: LightSeaGreen'>LightSeaGreen</span>
	public static const Color LightSeaGreen = Color.fromRGB(0x20B2AA);
	/// HTML color <span style='background-color: LightSkyBlue'>LightSkyBlue</span>
	public static const Color LightSkyBlue = Color.fromRGB(0x87CEFA);
	/// HTML color <span style='background-color: LightSlateGray'>LightSlateGray</span>
	public static const Color LightSlateGray = Color.fromRGB(0x778899);
	/// HTML color <span style='background-color: LightSteelBlue'>LightSteelBlue</span>
	public static const Color LightSteelBlue = Color.fromRGB(0xB0C4DE);
	/// HTML color <span style='background-color: LightYellow'>LightYellow</span>
	public static const Color LightYellow = Color.fromRGB(0xFFFFE0);
	/// HTML color <span style='background-color: Lime'>Lime</span>
	public static const Color Lime = Color.fromRGB(0x00FF00);
	/// HTML color <span style='background-color: LimeGreen'>LimeGreen</span>
	public static const Color LimeGreen = Color.fromRGB(0x32CD32);
	/// HTML color <span style='background-color: Linen'>Linen</span>
	public static const Color Linen = Color.fromRGB(0xFAF0E6);
	/// HTML color <span style='background-color: Magenta'>Magenta</span>
	public static const Color Magenta = Color.fromRGB(0xFF00FF);
	/// HTML color <span style='background-color: Maroon'>Maroon</span>
	public static const Color Maroon = Color.fromRGB(0x800000);
	/// HTML color <span style='background-color: MediumAquaMarine'>MediumAquaMarine</span>
	public static const Color MediumAquaMarine = Color.fromRGB(0x66CDAA);
	/// HTML color <span style='background-color: MediumBlue'>MediumBlue</span>
	public static const Color MediumBlue = Color.fromRGB(0x0000CD);
	/// HTML color <span style='background-color: MediumOrchid'>MediumOrchid</span>
	public static const Color MediumOrchid = Color.fromRGB(0xBA55D3);
	/// HTML color <span style='background-color: MediumPurple'>MediumPurple</span>
	public static const Color MediumPurple = Color.fromRGB(0x9370DB);
	/// HTML color <span style='background-color: MediumSeaGreen'>MediumSeaGreen</span>
	public static const Color MediumSeaGreen = Color.fromRGB(0x3CB371);
	/// HTML color <span style='background-color: MediumSlateBlue'>MediumSlateBlue</span>
	public static const Color MediumSlateBlue = Color.fromRGB(0x7B68EE);
	/// HTML color <span style='background-color: MediumSpringGreen'>MediumSpringGreen</span>
	public static const Color MediumSpringGreen = Color.fromRGB(0x00FA9A);
	/// HTML color <span style='background-color: MediumTurquoise'>MediumTurquoise</span>
	public static const Color MediumTurquoise = Color.fromRGB(0x48D1CC);
	/// HTML color <span style='background-color: MediumVioletRed'>MediumVioletRed</span>
	public static const Color MediumVioletRed = Color.fromRGB(0xC71585);
	/// HTML color <span style='background-color: MidnightBlue'>MidnightBlue</span>
	public static const Color MidnightBlue = Color.fromRGB(0x191970);
	/// HTML color <span style='background-color: MintCream'>MintCream</span>
	public static const Color MintCream = Color.fromRGB(0xF5FFFA);
	/// HTML color <span style='background-color: MistyRose'>MistyRose</span>
	public static const Color MistyRose = Color.fromRGB(0xFFE4E1);
	/// HTML color <span style='background-color: Moccasin'>Moccasin</span>
	public static const Color Moccasin = Color.fromRGB(0xFFE4B5);
	/// HTML color <span style='background-color: NavajoWhite'>NavajoWhite</span>
	public static const Color NavajoWhite = Color.fromRGB(0xFFDEAD);
	/// HTML color <span style='background-color: Navy'>Navy</span>
	public static const Color Navy = Color.fromRGB(0x000080);
	/// HTML color <span style='background-color: OldLace'>OldLace</span>
	public static const Color OldLace = Color.fromRGB(0xFDF5E6);
	/// HTML color <span style='background-color: Olive'>Olive</span>
	public static const Color Olive = Color.fromRGB(0x808000);
	/// HTML color <span style='background-color: OliveDrab'>OliveDrab</span>
	public static const Color OliveDrab = Color.fromRGB(0x6B8E23);
	/// HTML color <span style='background-color: Orange'>Orange</span>
	public static const Color Orange = Color.fromRGB(0xFFA500);
	/// HTML color <span style='background-color: OrangeRed'>OrangeRed</span>
	public static const Color OrangeRed = Color.fromRGB(0xFF4500);
	/// HTML color <span style='background-color: Orchid'>Orchid</span>
	public static const Color Orchid = Color.fromRGB(0xDA70D6);
	/// HTML color <span style='background-color: PaleGoldenRod'>PaleGoldenRod</span>
	public static const Color PaleGoldenRod = Color.fromRGB(0xEEE8AA);
	/// HTML color <span style='background-color: PaleGreen'>PaleGreen</span>
	public static const Color PaleGreen = Color.fromRGB(0x98FB98);
	/// HTML color <span style='background-color: PaleTurquoise'>PaleTurquoise</span>
	public static const Color PaleTurquoise = Color.fromRGB(0xAFEEEE);
	/// HTML color <span style='background-color: PaleVioletRed'>PaleVioletRed</span>
	public static const Color PaleVioletRed = Color.fromRGB(0xDB7093);
	/// HTML color <span style='background-color: PapayaWhip'>PapayaWhip</span>
	public static const Color PapayaWhip = Color.fromRGB(0xFFEFD5);
	/// HTML color <span style='background-color: PeachPuff'>PeachPuff</span>
	public static const Color PeachPuff = Color.fromRGB(0xFFDAB9);
	/// HTML color <span style='background-color: Peru'>Peru</span>
	public static const Color Peru = Color.fromRGB(0xCD853F);
	/// HTML color <span style='background-color: Pink'>Pink</span>
	public static const Color Pink = Color.fromRGB(0xFFC0CB);
	/// HTML color <span style='background-color: Plum'>Plum</span>
	public static const Color Plum = Color.fromRGB(0xDDA0DD);
	/// HTML color <span style='background-color: PowderBlue'>PowderBlue</span>
	public static const Color PowderBlue = Color.fromRGB(0xB0E0E6);
	/// HTML color <span style='background-color: Purple'>Purple</span>
	public static const Color Purple = Color.fromRGB(0x800080);
	/// HTML color <span style='background-color: RebeccaPurple'>RebeccaPurple</span>
	public static const Color RebeccaPurple = Color.fromRGB(0x663399);
	/// HTML color <span style='background-color: Red'>Red</span>
	public static const Color Red = Color.fromRGB(0xFF0000);
	/// HTML color <span style='background-color: RosyBrown'>RosyBrown</span>
	public static const Color RosyBrown = Color.fromRGB(0xBC8F8F);
	/// HTML color <span style='background-color: RoyalBlue'>RoyalBlue</span>
	public static const Color RoyalBlue = Color.fromRGB(0x4169E1);
	/// HTML color <span style='background-color: SaddleBrown'>SaddleBrown</span>
	public static const Color SaddleBrown = Color.fromRGB(0x8B4513);
	/// HTML color <span style='background-color: Salmon'>Salmon</span>
	public static const Color Salmon = Color.fromRGB(0xFA8072);
	/// HTML color <span style='background-color: SandyBrown'>SandyBrown</span>
	public static const Color SandyBrown = Color.fromRGB(0xF4A460);
	/// HTML color <span style='background-color: SeaGreen'>SeaGreen</span>
	public static const Color SeaGreen = Color.fromRGB(0x2E8B57);
	/// HTML color <span style='background-color: SeaShell'>SeaShell</span>
	public static const Color SeaShell = Color.fromRGB(0xFFF5EE);
	/// HTML color <span style='background-color: Sienna'>Sienna</span>
	public static const Color Sienna = Color.fromRGB(0xA0522D);
	/// HTML color <span style='background-color: Silver'>Silver</span>
	public static const Color Silver = Color.fromRGB(0xC0C0C0);
	/// HTML color <span style='background-color: SkyBlue'>SkyBlue</span>
	public static const Color SkyBlue = Color.fromRGB(0x87CEEB);
	/// HTML color <span style='background-color: SlateBlue'>SlateBlue</span>
	public static const Color SlateBlue = Color.fromRGB(0x6A5ACD);
	/// HTML color <span style='background-color: SlateGray'>SlateGray</span>
	public static const Color SlateGray = Color.fromRGB(0x708090);
	/// HTML color <span style='background-color: Snow'>Snow</span>
	public static const Color Snow = Color.fromRGB(0xFFFAFA);
	/// HTML color <span style='background-color: SpringGreen'>SpringGreen</span>
	public static const Color SpringGreen = Color.fromRGB(0x00FF7F);
	/// HTML color <span style='background-color: SteelBlue'>SteelBlue</span>
	public static const Color SteelBlue = Color.fromRGB(0x4682B4);
	/// HTML color <span style='background-color: Tan'>Tan</span>
	public static const Color Tan = Color.fromRGB(0xD2B48C);
	/// HTML color <span style='background-color: Teal'>Teal</span>
	public static const Color Teal = Color.fromRGB(0x008080);
	/// HTML color <span style='background-color: Thistle'>Thistle</span>
	public static const Color Thistle = Color.fromRGB(0xD8BFD8);
	/// HTML color <span style='background-color: Tomato'>Tomato</span>
	public static const Color Tomato = Color.fromRGB(0xFF6347);
	/// HTML color <span style='background-color: Turquoise'>Turquoise</span>
	public static const Color Turquoise = Color.fromRGB(0x40E0D0);
	/// HTML color <span style='background-color: Violet'>Violet</span>
	public static const Color Violet = Color.fromRGB(0xEE82EE);
	/// HTML color <span style='background-color: Wheat'>Wheat</span>
	public static const Color Wheat = Color.fromRGB(0xF5DEB3);
	/// HTML color <span style='background-color: White'>White</span>
	public static const Color White = Color.fromRGB(0xFFFFFF);
	/// HTML color <span style='background-color: WhiteSmoke'>WhiteSmoke</span>
	public static const Color WhiteSmoke = Color.fromRGB(0xF5F5F5);
	/// HTML color <span style='background-color: Yellow'>Yellow</span>
	public static const Color Yellow = Color.fromRGB(0xFFFF00);
	/// HTML color <span style='background-color: YellowGreen'>YellowGreen</span>
	public static const Color YellowGreen = Color.fromRGB(0x9ACD32);

	/// Creates a new 24 bit color using 3x 8 bit components.
	/// Params:
	///     r = Red value in range 0 - 255
	///     g = Green value in range 0 - 255
	///     b = Blue value in range 0 - 255
	public this(ubyte r, ubyte g, ubyte b)
	{
		_r = r;
		_g = g;
		_b = b;
	}

	/// Creates a new 24 bit color.
	/// Params:
	///     hex = integer in RGB byte order
	public static Color fromRGB(const int hex)
	{
		return Color((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF);
	}

	/// Creates a new 24 bit color.
	/// Params:
	///     hex = integer in BGR byte order
	public static Color fromBGR(const int hex)
	{
		return Color(hex & 0xFF, (hex >> 8) & 0xFF, (hex >> 16) & 0xFF);
	}

	/// Converts from HSL to RGB
	/// Params:
	///     hue =        Hue in range 0 - 1
	///     saturation = Saturation in range 0 - 1
	///     lightness =  Lightness in range 0 - 1
	public void fromHSL(double hue, double saturation, double lightness)
	{
		double v = lightness <= 0.5 ? (lightness * (1 + saturation)) : (1 + saturation - lightness * saturation);
		double r, g, b;
		r = g = b = 1;

		if (v > 0)
		{
			double m;
			double sv;
			int sextant;
			double fract, vsf, mid1, mid2;

			m = lightness + lightness - v;
			sv = (v - m) / v;
			hue *= 6.0;
			sextant = cast(int) hue;
			fract = hue - sextant;
			vsf = v * sv * fract;
			mid1 = m + vsf;
			mid2 = v - vsf;
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

	/// Creates an SDL_Color from `this`.
	public @property SDL_Color sdl_color() const
	{
		return SDL_Color(_r, _g, _b, 255);
	}

	/// Red value in range 0 - 255 as a ubyte.
	public @property ref ubyte R()
	{
		return _r;
	}

	/// Green value in range 0 - 255 as a ubyte.
	public @property ref ubyte G()
	{
		return _g;
	}

	/// Blue value in range 0 - 255 as a ubyte.
	public @property ref ubyte B()
	{
		return _b;
	}

	/// Red value in range 0 - 1 as a float.
	public @property float fR() const
	{
		return _r * 0.00392156862f;
	}

	/// Green value in range 0 - 1 as a float.
	public @property float fG() const
	{
		return _g * 0.00392156862f;
	}

	/// Blue value in range 0 - 1 as a float.
	public @property float fB() const
	{
		return _b * 0.00392156862f;
	}

	/// RGB in range 0 - 1 as vec3
	public @property vec3 f() const
	{
		return vec3(fR, fG, fB);
	}

	/// Color as RGB hex.
	public @property int RGB() const
	{
		return _r << 16 | _g << 8 | _b;
	}

	/// Color as BGR hex.
	public @property int BGR() const
	{
		return _r | _g << 8 | _b << 16;
	}

	private ubyte _r, _g, _b;
}
