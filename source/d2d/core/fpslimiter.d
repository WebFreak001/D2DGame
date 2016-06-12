module d2d.core.fpslimiter;

import core.thread;
import std.datetime;

/**
 * Class for limiting your FPS.
 * Examples:
 * ---
 * FPSLimiter limiter = new FPSLimiter(25);
 * while(window.open)
 * {
 *     window.clear();
 *     // Draw and Update stuff
 *     window.display();
 *     limiter.wait();
 * }
 * ---
 */
class FPSLimiter
{
protected:
	int _fps = 0;
	int _skiphns = 0;
	ulong _next = 0;
	long _sleep = 0;

public:
	/// Creates a new FPS Limiter instance with specified max FPS.
	this(int maxFPS)
	{
		_fps = maxFPS;
		_skiphns = 10_000_000 / _fps;
		_next = Clock.currStdTime();
	}

	/// Calculates how long to wait and then waits that amount of time to ensure the target FPS.
	void wait()
	{
		_next += _skiphns;
		_sleep = _next - Clock.currStdTime();
		if (_sleep > 0)
		{
			Thread.sleep(dur!("hnsecs")(_sleep));
		}
	}
}
