module d2d.core.idisposable;

/**
 * Interface containing a delete function. Often combined with IVerifiable.
 * Examples:
 * ---
 * class A : IDisposable
 * {
 *     ~this()
 *     {
 *         dispose();
 *     }
 *
 *     public void dispose()
 *     {
 *         // Delete Native Stuff
 *     }
 * }
 * ---
 */
interface IDisposable
{
	/// Function for deallocating memory. Should be called in destructor.
	public void dispose();
}
