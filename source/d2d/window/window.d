module d2d.window.window;

import d2d;

/// Single-Window class wrapping SDL_Window.
class Window : IVerifiable, IDisposable, IRenderTarget
{
private:
	SDL_Window* _handle;
	int _id;
	uint _fbo, _drb;
	Texture _texture;
	RectangleShape _displayPlane;
	bool _direct = false;
	mat4 _postMatrix;

public:
	/// Static variable to a SDL GL Context.
	static SDL_GLContext glContext = null;

	/// Creates a new centered window with specified title and flags on a 800x480 resolution.
	this(string title = "D2DGame", uint flags = WindowFlags.Default) { this(800, 480, title, flags); }

	/// Creates a new centered window with specified dimensions, title and flags.
	this(int width, int height, string title = "D2DGame", uint flags = WindowFlags.Default)
	{
		this(SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, title, flags);
	}

	/// Creates a new window with specified parameters.
	this(int x, int y, int width, int height, string title, uint flags = WindowFlags.Default)
	{
		DerelictSDL2.load();
		DerelictSDL2Image.load();
		DerelictSDL2Mixer.load();
		DerelictSDL2ttf.load();
		DerelictGL3.load();

		SDL_Init(SDL_INIT_EVERYTHING);

		if (TTF_Init() == -1)
		{
			std.stdio.writeln("Error Initializing SDL_TTF: ", TTF_GetError());
		}

		_handle = SDL_CreateWindow(title.toStringz(), x, y, width, height, flags | SDL_WINDOW_OPENGL);
		if (!valid)
			throw new Exception("Couldn't create window!");
		_id = SDL_GetWindowID(_handle);

		SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 16);
		SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE, 0);

		SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
		SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);

		glContext = SDL_GL_CreateContext(_handle);

		SDL_GL_SetSwapInterval(0);

		DerelictGL3.reload();

		if (SDL_GL_MakeCurrent(_handle, glContext) < 0)
			throw new Exception(cast(string) fromStringz(SDL_GetError()));

		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

		ShaderProgram.load();
		Texture.load();
		if (!Music.load())
			throw new Exception(Music.error);

		create(width, height);

		_displayPlane = new RectangleShape();
		_displayPlane.setSize(vec2(1, 1));
		_displayPlane.texture = _texture;

		_postMatrix = mat4.orthographic(0, 1, 0, 1, -1, 1);
	}

	~this()
	{
		if (valid)
			dispose();
	}

	/// Polls a event from the stack and returns `true` if one was found.
	bool pollEvent(ref WindowEvent event)
	{
		SDL_Event evt;
		if (SDL_PollEvent(&evt))
		{
			event = WindowEvent();
			event.fromSDL(evt);
			return true;
		}
		return false;
	}

	/// Pushes `WindowEvent.Quit` to the event stack.
	void quit()
	{
		SDL_Event sdlevent;
		sdlevent.type = SDL_QUIT;
		SDL_PushEvent(&sdlevent);
	}

	void bind()
	{
		if (!_direct)
		{
			glBindFramebuffer(GL_FRAMEBUFFER, _fbo);
			glViewport(0, 0, _texture.width, _texture.height);
		}
	}

	void resize(int width, int height)
	{
		glDeleteFramebuffers(1, &_fbo);
		_texture.dispose();
		create(width, height);
		_displayPlane.texture = _texture;
		projectionStack.set(mat4.orthographic(0, width, height, 0, -1, 1));
	}

	void create(int width, int height)
	{
		glGenFramebuffers(1, &_fbo);
		glBindFramebuffer(GL_FRAMEBUFFER, _fbo);

		_texture = new Texture();
		_texture.minFilter = TextureFilterMode.Nearest;
		_texture.magFilter = TextureFilterMode.Nearest;
		_texture.create(width, height, GL_RGB, null);

		glGenRenderbuffers(1, &_drb);
		glBindRenderbuffer(GL_RENDERBUFFER, _drb);
		glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT, width, height);
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _drb);

		glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, _texture.id, 0);

		glDrawBuffers(1, [GL_COLOR_ATTACHMENT0].ptr);
		projectionStack.set(mat4.orthographic(0, width, height, 0, -1, 1));
		if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
			throw new Exception("Invalid Framebuffer");
	}

	/// Texture containing rendered content.
	@property Texture texture()
	{
		return _texture;
	}

	/// Displays rendered content to the window.
	void display(ShaderProgram post = null)
	{
		glBindFramebuffer(GL_FRAMEBUFFER, 0);
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		glViewport(0, 0, x, y);
		glClearColor(Color3.BlueViolet, 1);
		glClear(GL_COLOR_BUFFER_BIT);
		_direct = true;
		projectionStack.push();
		projectionStack.set(_postMatrix);
		matrixStack.push();
		matrixStack.set(mat4.identity);
		draw(_displayPlane, post);
		matrixStack.pop();
		projectionStack.pop();
		_direct = false;
		SDL_GL_SwapWindow(_handle);
	}

	/// Dynamically sets the title of the window.
	@property void title(string title)
	{
		SDL_SetWindowTitle(_handle, title.toStringz());
	}

	/// Dynamically gets the title of the window.
	@property string title()
	{
		string title = SDL_GetWindowTitle(_handle).fromStringz().dup;
		return title;
	}

	/// Dynamically sets the width of the window.
	@property void width(int width)
	{
		SDL_SetWindowSize(_handle, width, height);
		resize(width, height);
	}

	/// Dynamically gets the width of the window.
	@property int width()
	{
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		return x;
	}

	/// Dynamically sets the height of the window.
	@property void height(int height)
	{
		SDL_SetWindowSize(_handle, width, height);
		resize(width, height);
	}

	/// Dynamically gets the height of the window.
	@property int height()
	{
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		return y;
	}

	/// Dynamically sets the maximum width of the window.
	@property void maxWidth(int maxWidth)
	{
		SDL_SetWindowMaximumSize(_handle, maxWidth, maxHeight);
	}

	/// Dynamically gets the maximum width of the window.
	@property int maxWidth()
	{
		int x, y;
		SDL_GetWindowMaximumSize(_handle, &x, &y);
		return x;
	}

	/// Dynamically sets the maximum height of the window.
	@property void maxHeight(int maxHeight)
	{
		SDL_SetWindowMaximumSize(_handle, maxWidth, maxHeight);
	}

	/// Dynamically gets the maximum height of the window.
	@property int maxHeight()
	{
		int x, y;
		SDL_GetWindowMaximumSize(_handle, &x, &y);
		return y;
	}

	/// Dynamically sets the minimum width of the window.
	@property void minWidth(int minWidth)
	{
		SDL_SetWindowMinimumSize(_handle, minWidth, minHeight);
	}

	/// Dynamically gets the minimum width of the window.
	@property int minWidth()
	{
		int x, y;
		SDL_GetWindowMinimumSize(_handle, &x, &y);
		return x;
	}

	/// Dynamically sets the minimum height of the window.
	@property void minHeight(int minHeight)
	{
		SDL_SetWindowMinimumSize(_handle, minWidth, minHeight);
	}

	/// Dynamically gets the minimum height of the window.
	@property int minHeight()
	{
		int x, y;
		SDL_GetWindowMinimumSize(_handle, &x, &y);
		return y;
	}

	/// Dynamically sets the x position of the window.
	@property void x(int x)
	{
		SDL_SetWindowPosition(_handle, x, y);
	}

	/// Dynamically gets the x position of the window.
	@property int x()
	{
		int x, y;
		SDL_GetWindowPosition(_handle, &x, &y);
		return x;
	}

	/// Dynamically sets the y position of the window.
	@property void y(int y)
	{
		SDL_SetWindowPosition(_handle, x, y);
	}

	/// Dynamically gets the y position of the window.
	@property int y()
	{
		int x, y;
		SDL_GetWindowPosition(_handle, &x, &y);
		return y;
	}

	/// Shows the window if hidden.
	void show()
	{
		SDL_ShowWindow(_handle);
	}

	/// Hides the window.
	void hide()
	{
		SDL_HideWindow(_handle);
	}

	/// Minimizes the window.
	void minimize()
	{
		SDL_MinimizeWindow(_handle);
	}

	/// Maximizes the window.
	void maximize()
	{
		SDL_MaximizeWindow(_handle);
	}

	/// Restores the window state from minimized or maximized.
	void restore()
	{
		SDL_RestoreWindow(_handle);
	}

	/// Raises the window to top and focuses it for input.
	void focus()
	{
		SDL_RaiseWindow(_handle);
	}

	/// Sets the icon to a Btimap.
	void setIcon(Bitmap icon)
	{
		SDL_SetWindowIcon(_handle, icon.surface);
	}

	/// Closes the window and invalidates it.
	/// See_Also: Window.close
	void dispose()
	{
		glDeleteFramebuffers(1, &_fbo);
		_texture.dispose();
		if (valid)
		{
			SDL_DestroyWindow(_handle);
			_handle = null;
		}
	}

	/// Closes the window and invalidates it.
	/// See_Also: Window.dispose
	void close()
	{
		dispose();
	}

	/// Returns if the is still open.
	/// See_Also: Window.valid
	@property bool open()
	{
		return valid;
	}

	/// Returns if the window is still open.
	/// See_Also: Window.open
	@property bool valid()
	{
		return _handle !is null;
	}
}

///
unittest
{
	Window window = new Window(800, 600, "Unittest");

	assert(window.valid);

	assert(window.title == "Unittest");
	window.title = "Window Title";
	assert(window.title == "Window Title");
	// Automatic conversion from c-strings to D-strings

	assert(window.width == 800);

	window.close();
	assert(!window.valid);
}
