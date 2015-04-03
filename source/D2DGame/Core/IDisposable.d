module D2DGame.Core.IDisposable;

/**
 * Interface containing a delete function. Often combined with IVerifiable.
 * Examples:
 * ---
 * class A : IDisposable
 * {
 *  ~this()
 *  {
 *      dispose();
 *  }
 *
 *  public void dispose()
 *  {
 *      // Delete Native Stuff
 *  }
 * }
 * ---
 */
interface IDisposable
{
	///
	public void dispose();
}
