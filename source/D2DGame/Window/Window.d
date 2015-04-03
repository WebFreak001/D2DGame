module D2DGame.Window.Window;

import D2D;

class Window : IVerifiable, IDisposable, IRenderTarget
{
private:
	SDL_Window	   * _handle;
	int			   _id;
	uint		   _fbo, _drb;
	Texture		   _texture;
	RectangleShape _displayPlane;
	bool		   _direct = false;
	mat4		   _postMatrix;

public:
	static SDL_GLContext glContext = null;

	this(string title = "D2DGame", uint flags = WindowFlags.Default) { this(800, 480, title, flags); }

	this(int width, int height, string title = "D2DGame", uint flags = WindowFlags.Default)
	{
		this(SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, title, flags);
	}

	this(int x, int y, int width, int height, string title, uint flags = WindowFlags.Default)
	{
		DerelictSDL2.load();
		DerelictSDL2Image.load();
		DerelictGL3.load();
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
		DerelictGL3.reload();

		if (SDL_GL_MakeCurrent(_handle, glContext) < 0)
			throw new Exception(cast(string) fromStringz(SDL_GetError()));

		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

		ShaderProgram.load();

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
		_texture.resize(width, height);
		projectionStack.set(mat4.orthographic(0, width, height, 0, -1, 1));
	}

	void create(int width, int height)
	{
		glGenFramebuffers(1, &_fbo);
		glBindFramebuffer(GL_FRAMEBUFFER, _fbo);

		_texture		   = new Texture();
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

	@property Texture texture()
	{
		return _texture;
	}

	void display(ShaderProgram post = null)
	{
		glBindFramebuffer(GL_FRAMEBUFFER, 0);
		glViewport(0, 0, width, height);
		glClearColor(Color3.BlueViolet, 1);
		glClear(GL_COLOR_BUFFER_BIT);
		_direct = true;
		projectionStack.push();
		projectionStack.set(_postMatrix);
		draw(_displayPlane, post);
		projectionStack.pop();
		_direct = false;
		SDL_GL_SwapWindow(_handle);
	}

	@property void title(string title)
	{
		SDL_SetWindowTitle(_handle, title.toStringz());
	}

	@property string title()
	{
		string title = SDL_GetWindowTitle(_handle).fromStringz().dup;
		return title;
	}

	@property void width(int width)
	{
		SDL_SetWindowSize(_handle, width, height);
		resize(width, height);
	}

	@property int width()
	{
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		return x;
	}

	@property void height(int height)
	{
		SDL_SetWindowSize(_handle, width, height);
		resize(width, height);
	}

	@property int height()
	{
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		return y;
	}

	@property void maxWidth(int maxWidth)
	{
		SDL_SetWindowMaximumSize(_handle, maxWidth, maxHeight);
	}

	@property int maxWidth()
	{
		int x, y;
		SDL_GetWindowMaximumSize(_handle, &x, &y);
		return x;
	}

	@property void maxHeight(int maxHeight)
	{
		SDL_SetWindowMaximumSize(_handle, maxWidth, maxHeight);
	}

	@property int maxHeight()
	{
		int x, y;
		SDL_GetWindowMaximumSize(_handle, &x, &y);
		return y;
	}

	@property void minWidth(int minWidth)
	{
		SDL_SetWindowMinimumSize(_handle, minWidth, minHeight);
	}

	@property int minWidth()
	{
		int x, y;
		SDL_GetWindowMinimumSize(_handle, &x, &y);
		return x;
	}

	@property void minHeight(int minHeight)
	{
		SDL_SetWindowMinimumSize(_handle, minWidth, minHeight);
	}

	@property int minHeight()
	{
		int x, y;
		SDL_GetWindowMinimumSize(_handle, &x, &y);
		return y;
	}

	@property void x(int x)
	{
		SDL_SetWindowPosition(_handle, x, y);
	}

	@property int x()
	{
		int x, y;
		SDL_GetWindowPosition(_handle, &x, &y);
		return x;
	}

	@property void y(int y)
	{
		SDL_SetWindowPosition(_handle, x, y);
	}

	@property int y()
	{
		int x, y;
		SDL_GetWindowPosition(_handle, &x, &y);
		return y;
	}

	void show()
	{
		SDL_ShowWindow(_handle);
	}

	void hide()
	{
		SDL_HideWindow(_handle);
	}

	void minimized()
	{
		SDL_MinimizeWindow(_handle);
	}

	void maximize()
	{
		SDL_MaximizeWindow(_handle);
	}

	void restore()
	{
		SDL_RestoreWindow(_handle);
	}

	void focus()
	{
		SDL_RaiseWindow(_handle);
	}

	void setIcon(Bitmap icon)
	{
		SDL_SetWindowIcon(_handle, icon.surface);
	}

	void dispose()
	{
		SDL_DestroyWindow(_handle);
		_handle = null;
	}

	void close()
	{
		dispose();
	}

	bool isOpen()
	{
		return valid;
	}

	@property bool valid()
	{
		return _handle !is null;
	}
}
