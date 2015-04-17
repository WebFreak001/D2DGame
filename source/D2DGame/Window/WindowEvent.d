module D2DGame.Window.WindowEvent;

import D2D;

import std.math : abs;

/// Event structure on Window Events.
struct WindowEvent
{
	/// Types that can occur when WindowEvents are fired.
	enum Type
	{
		Undefined,
		/// Occurs when X button is clicked.
		Close,
		/// Occurs when window got resized.
		Resized,
		/// Occurs when window got moved.
		Moved,
		/// Occurs when window lost focus.
		LostFocus,
		/// Occurs when window gained focus again.
		GainedFocus,
		/// Occurs when `window.show` got called.
		Shown,
		/// Occurs when `window.hide` got called.
		Hidden,
		/// Occurs when the window minimizes.
		Minimized,
		/// Occurs when the window maximizes.
		Maximized,
		/// Occurs when the window restores from minimized/maximized state.
		Restored,
		/// Occurs when the user typed some text on the keyboard for text fields.
		TextEntered,
		/// Occurs when the user presses a key on the keyboard. Will fire repeatedly when held down.
		KeyPressed,
		/// Occurs when the user releases a key on the keyboard.
		KeyReleased,
		/// Occurs when the user scrolled.
		MouseWheelMoved,
		/// Occurs when the user pressed a mouse button.
		MouseButtonPressed,
		/// Occurs when the user released a mouse button.
		MouseButtonReleased,
		/// Occurs when the user moved the mouse.
		MouseMoved,
		/// Occurs when the mouse hovers over the window.
		MouseEntered,
		/// Occurs when the mouse no longer hovers over the window
		MouseLeft,
		/// Occurs when a button on a controller got pressed.
		ControllerButtonPressed,
		/// Occurs when a button on a controller got released.
		ControllerButtonReleased,
		/// Occurs when an axis on a controller got moved.
		ControllerAxis,
		/// Occurs when a controller connected.
		ControllerConnected,
		/// Occurs when a controller disconnected.
		ControllerDisconnected,
		/// Occurs when window is closing.
		Quit
	}

	Type   type;

	/// x/width in events.
	int	   x;
	/// y/height in events.
	int	   y;
	/// Relative mouse coordinates in Mouse events.
	int	   xrel, yrel;
	/// Mouse button in Mouse events.
	int	   mousebutton;
	/// Key in Controller and Keyboard events.
	int	   key;
	/// Controller id in Controller* event.
	int	   controllerID;
	/// Axis id in ControllerAxis event.
	int	   axis;
	/// Axis value in ControllerAxis event.
	short  axisValue;
	/// Text contained in TextEntered event.
	string text;

	/// Function for converting a SDL event to a WindowEvent
	void   fromSDL(const ref SDL_Event event)
	{
		switch (event.type)
		{
		case SDL_WINDOWEVENT:
			switch (event.window.event)
			{
			case SDL_WINDOWEVENT_SHOWN:
				type = Type.Shown;
				break;
			case SDL_WINDOWEVENT_HIDDEN:
				type = Type.Hidden;
				break;
			case SDL_WINDOWEVENT_MOVED:
				type = Type.Moved;
				x	 = event.window.data1;
				y	 = event.window.data2;
				break;
			case SDL_WINDOWEVENT_RESIZED:
				type = Type.Resized;
				x	 = event.window.data1;
				y	 = event.window.data2;
				break;
			case SDL_WINDOWEVENT_MINIMIZED:
				type = Type.Minimized;
				break;
			case SDL_WINDOWEVENT_MAXIMIZED:
				type = Type.Maximized;
				break;
			case SDL_WINDOWEVENT_RESTORED:
				type = Type.Restored;
				break;
			case SDL_WINDOWEVENT_ENTER:
				type = Type.MouseEntered;
				break;
			case SDL_WINDOWEVENT_LEAVE:
				type = Type.MouseLeft;
				break;
			case SDL_WINDOWEVENT_FOCUS_GAINED:
				type = Type.GainedFocus;
				break;
			case SDL_WINDOWEVENT_FOCUS_LOST:
				type = Type.LostFocus;
				break;
			case SDL_WINDOWEVENT_CLOSE:
				type = Type.Close;
				break;
			default:
				type = Type.Undefined;
				break;
			}
			break;
		case SDL_KEYDOWN:
			type = Type.KeyPressed;
			key	 = event.key.keysym.sym;
			break;
		case SDL_KEYUP:
			type = Type.KeyReleased;
			key	 = event.key.keysym.sym;
			break;
		case SDL_MOUSEWHEEL:
			type = Type.MouseWheelMoved;
			x	 = event.wheel.x;
			y	 = event.wheel.y;
			break;
		case SDL_MOUSEMOTION:
			type = Type.MouseMoved;
			x	 = event.motion.x;
			y	 = event.motion.y;
			xrel = event.motion.xrel;
			yrel = event.motion.yrel;
			break;
		case SDL_MOUSEBUTTONDOWN:
			type		= Type.MouseButtonPressed;
			x			= event.button.x;
			y			= event.button.y;
			mousebutton = event.button.button;
			break;
		case SDL_MOUSEBUTTONUP:
			type		= Type.MouseButtonReleased;
			x			= event.button.x;
			y			= event.button.y;
			mousebutton = event.button.button;
			break;
		case SDL_CONTROLLERDEVICEADDED:
			type		 = Type.ControllerConnected;
			controllerID = event.cdevice.which;
			SDL_GameControllerOpen(controllerID);
			break;
		case SDL_CONTROLLERDEVICEREMOVED:
			type		 = Type.ControllerDisconnected;
			controllerID = event.cdevice.which;
			break;
		case SDL_CONTROLLERBUTTONDOWN:
			type		 = Type.ControllerButtonPressed;
			controllerID = event.cbutton.which;
			key			 = event.cbutton.button;
			break;
		case SDL_CONTROLLERBUTTONUP:
			type		 = Type.ControllerButtonReleased;
			controllerID = event.cbutton.which;
			key			 = event.cbutton.button;
			break;
		case SDL_CONTROLLERAXISMOTION:
			type = Type.ControllerAxis;
			short value = event.caxis.value;
			if (value < -32767)
				value = -32767;
			if ((event.caxis.axis == 0 || event.caxis.axis == 1) && abs(value) < 7849)
			{
				value = 0;
			}
			if ((event.caxis.axis == 2 || event.caxis.axis == 3) && abs(value) < 8689)
			{
				value = 0;
			}
			if ((event.caxis.axis == 4 || event.caxis.axis == 5) && abs(value) < 30)
			{
				value = 0;
			}
			axis	  = event.caxis.axis;
			axisValue = value;
			break;
		case SDL_TEXTINPUT:
			type = Type.TextEntered;
			text = cast(string) fromStringz(event.text.text.ptr);
			break;
		case SDL_QUIT:
			type = Type.Quit;
			break;
		default:
			type = Type.Undefined;
			break;
		}
	}
}

///
unittest
{
	SDL_Event	source;
	WindowEvent event;
	source.type			  = SDL_KEYDOWN;
	source.key.keysym.sym = 42;
	event.fromSDL(source);

	assert(event.type == WindowEvent.Type.KeyPressed);
	assert(event.key == 42);
}

///
alias Event = WindowEvent;
