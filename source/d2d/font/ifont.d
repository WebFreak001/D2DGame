module d2d.font.ifont;

import d2d;

/// Interface for font loaders.
interface IFont : IDisposable, IVerifiable
{
	/// Loads the font from a file. Size may not do anything with bitmap fonts, use IText.scale instead!
	void load(string file, int sizeInPt);

	/// Renders a string to an IText.
	IText render(string text, float scale = 1.0f);

	/// Renders a multiline string to an IText.
	IText renderMultiline(string text, float scale = 1.0f);

	/// Returns the dimensions of a string with this font.
	vec2 measureText(string text, float scale = 1.0f);

	/// Returns the dimensions of a multiline string with this font.
	vec2 measureTextMultiline(string text, float scale = 1.0f);
}
