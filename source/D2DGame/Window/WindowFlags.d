module D2DGame.Window.WindowFlags;

import D2D;

enum WindowFlags : uint
{
	Fullscreen     = SDL_WINDOW_FULLSCREEN,
	FullscreenAuto = SDL_WINDOW_FULLSCREEN_DESKTOP,
	Shown          = SDL_WINDOW_SHOWN,
	Hidden         = SDL_WINDOW_HIDDEN,
	Borderless     = SDL_WINDOW_BORDERLESS,
	Resizable      = SDL_WINDOW_RESIZABLE,
	Minimized      = SDL_WINDOW_MINIMIZED,
	Maximized      = SDL_WINDOW_MAXIMIZED,
	Focused        = SDL_WINDOW_INPUT_FOCUS | SDL_WINDOW_MOUSE_FOCUS,
	HighDPI        = SDL_WINDOW_ALLOW_HIGHDPI,
	Default        = Shown | Resizable | Focused,
}
