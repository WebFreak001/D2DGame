module d2d.toolkit.game;

import d2d;

import std.datetime.stopwatch;

/// Class for easily creating a window
abstract class Game
{
private:
	int _width = 800, _height = 480;
	Bitmap _icon = null;
	Window _window = null;
	string _title = "Game";
	int _fps = 60;
	StopWatch _stopwatch;
	WindowFlags _flags = WindowFlags.Default;
	ShaderProgram _postShader = null;

protected:
	/// Window start width, will not update afterwards
	@property ref int windowWidth()
	{
		return _width;
	}

	/// Window start height, will not update afterwards
	@property ref int windowHeight()
	{
		return _height;
	}

	/// Window icon, will not update afterwards
	@property ref Bitmap windowIcon()
	{
		return _icon;
	}

	/// Window title, will not update afterwards
	@property ref string windowTitle()
	{
		return _title;
	}

	/// Max FPS, will not update afterwards
	@property ref int maxFPS()
	{
		return _fps;
	}

	/// Window start flags, will not update afterwards
	@property ref WindowFlags flags()
	{
		return _flags;
	}

	/// Handle to the window.
	@property Window window()
	{
		return _window;
	}

	/// Optional post processing shader.
	@property ref ShaderProgram postShader()
	{
		return _postShader;
	}

	/// Start function will get called before window is created. Variables can be changed here.
	abstract void start();

	/// Load function thats meant for loading content.
	abstract void load();

	/// Will get called every frame before `draw`.
	abstract void update(float delta);

	/// Draw code goes here, `window.display` is not needed.
	abstract void draw();

	/// Happens when some window event gets called.
	void onEvent(Event event);

public:
	/// Starts the window and calls all functions
	void run()
	{
		start();

		_window = new Window(_width, _height, _title, _flags);

		if (_icon is null)
		{
			//dfmt off
			_icon = new Bitmap(
				[
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
					0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0x00ffffff,
					0xffffffff, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff9c9c9c, 0xff000000, 0xff000000, 0xff000000, 0xff383838, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xff303030, 0xff303030, 0xff303030, 0xff1c1c1c, 0xff000000, 0xff9c9c9c, 0xffcccccc, 0xff000000, 0xff292929, 0xff303030, 0xff292929, 0xff000000, 0xff6d6d6d, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff707070, 0xff131313, 0xff000000, 0xffcccccc, 0xff303030, 0xffb7b7b7, 0xffcccccc, 0xffb7b7b7, 0xff131313, 0xff000000, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff555555, 0xff000000, 0xff9c9c9c, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff1e1e1e, 0xff000000, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffa7a7a7, 0xff000000, 0xff6d6d6d, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffb0b0b0, 0xff000000, 0xff555555, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffb0b0b0, 0xff000000, 0xff727272, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff333333, 0xff0d0d0d, 0xffa7a7a7, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff8b8b8b, 0xff000000, 0xff909090, 0xffcccccc, 0xffcccccc, 0xff545454, 0xff000000, 0xff5b5b5b, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff444444, 0xff060606, 0xffb7b7b7, 0xffcccccc, 0xff545454, 0xff000000, 0xff454545, 0xffcccccc, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xff545454, 0xff000000, 0xff343434, 0xffcccccc, 0xff545454, 0xff000000, 0xff303030, 0xffcccccc, 0xffcccccc, 0xffcccccc, 0xffffffff,
					0xffffffff, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff303030, 0xffa7a7a7, 0xffb0b0b0, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xff000000, 0xffffffff,
					0xffffffff, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff454545, 0xffcccccc, 0xffcccccc, 0xffb7b7b7, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xff303030, 0xffffffff,
					0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff, 0x00ffffff,
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
					0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
				], 16, 16, 32, 0x00FF0000, 0x0000FF00, 0x000000FF, 0xFF000000);
			//dfmt on
		}

		_window.setIcon(_icon);

		FPSLimiter limiter;
		if (_fps > 0)
			limiter = new FPSLimiter(_fps);

		load();

		Event event;
		Duration delta;
		while (_window.open)
		{
			_stopwatch.start();
			while (_window.pollEvent(event))
			{
				if (event.type == Event.Type.Quit)
					_window.close();
				else
					onEvent(event);
			}

			update(delta.total!"hnsecs" / 10_000_000.0f);

			draw();

			if (_postShader !is null)
				_window.display(_postShader);
			else
				_window.display();

			if (limiter !is null)
				limiter.wait();

			_stopwatch.stop();
			delta = _stopwatch.peek();
			_stopwatch.reset();
		}
	}
}
