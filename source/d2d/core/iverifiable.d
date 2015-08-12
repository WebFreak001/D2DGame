module d2d.core.iverifiable;

/// Interface containing a isValid function. Often combined with IDisposable.
interface IVerifiable
{
	/// Function for checking if this is valid.
	public @property bool valid();
}
