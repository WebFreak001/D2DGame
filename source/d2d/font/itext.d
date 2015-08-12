module d2d.font.itext;

import d2d;

/// Interface containing text drawable functions.
interface IText : IDrawable, IDisposable, IVerifiable
{
	/// Gets the scale in percent.
	@property float size();
	/// Sets the scale in percent.
	@property void size(float value);

	/// Gets the text.
	@property string text();
	/// Modifies the text.
	@property void text(string value);
}
