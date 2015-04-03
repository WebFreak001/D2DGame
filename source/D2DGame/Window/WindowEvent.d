module D2DGame.Window.WindowEvent;

import D2D;

import std.math : abs;

struct WindowEvent
{
	enum Type
	{
		Undefined,
		Close,
		Resized, Moved,
		LostFocus, GainedFocus,
		Shown, Hidden,
		Minimized, Maximized, Restored,
		TextEntered,
		KeyPressed, KeyReleased,
		MouseWheelMoved, MouseButtonPressed, MouseButtonReleased, MouseMoved, MouseEntered, MouseLeft,
		ControllerButtonPressed, ControllerButtonReleased, ControllerAxis, ControllerConnected, ControllerDisconnected,
		Quit
	}

	Type   type;

	int	   x, y;
	int	   xrel, yrel;
	int	   mousebutton;
	int	   key;
	int	   controllerID;
	int	   axis;
	short  axisValue;
	string text;

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
		default: break;
		}
	}
}

alias Event = WindowEvent;
