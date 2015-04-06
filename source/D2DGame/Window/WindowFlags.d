module D2DGame.Window.WindowFlags;

import D2D;

/// Window creation flags.
enum WindowFlags : uint
{
	/// Fullscreen window with custom resolution.
	Fullscreen	   = SDL_WINDOW_FULLSCREEN,
	/// Fullscreen window without automatic resolution.
	FullscreenAuto = SDL_WINDOW_FULLSCREEN_DESKTOP,
	/// Directly show the window without calling `show();`
	Shown		   = SDL_WINDOW_SHOWN,
	/// Window is hidden by default and needs to be shown by `show();`
	Hidden		   = SDL_WINDOW_HIDDEN,
	/// Window has no border or title bar.
	Borderless	   = SDL_WINDOW_BORDERLESS,
	/// Window is resizable.
	Resizable	   = SDL_WINDOW_RESIZABLE,
	/// Window is initially started in minimized mode.
	Minimized	   = SDL_WINDOW_MINIMIZED,
	/// Window is initially started in maximized mode.
	Maximized	   = SDL_WINDOW_MAXIMIZED,
	/// Window directly gains input and mouse focus on startup.
	Focused		   = SDL_WINDOW_INPUT_FOCUS | SDL_WINDOW_MOUSE_FOCUS,
	/// Window allows high DPI monitors.
	HighDPI		   = SDL_WINDOW_ALLOW_HIGHDPI,
	/// Combination of `Shown | Focused`
	Default		   = Shown | Focused,
}

unittest
{
	assert((WindowFlags.Default | WindowFlags.HighDPI) == (WindowFlags.Shown | WindowFlags.Focused | WindowFlags.HighDPI));
}
