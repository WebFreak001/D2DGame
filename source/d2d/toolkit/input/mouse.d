module d2d.toolkit.input.mouse;

import d2d.window.windowevent;

struct Mouse
{
	@disable this(this);

	int x, y;
	int dx, dy;
	int wheelX, wheelY;
	int wheelDX, wheelDY;

	bool[32] buttons;

	static Mouse instance;

	Mouse dup()
	{
		return Mouse(x, y, dx, dy, wheelX, wheelY, wheelDX, wheelDY, buttons);
	}

	void move(int x, int y, int dx, int dy)
	{
		this.x = x;
		this.y = y;
		this.dx = dx;
		this.dy = dy;
	}

	void moveTo(int x, int y)
	{
		move(x, y, x - this.x, y - this.y);
	}

	void scroll(int dx, int dy)
	{
		wheelX += dx;
		wheelY += dy;
		wheelDX = dx;
		wheelDY = dy;
	}

	void click(int button, bool down)
	{
		buttons[button] = down;
	}

	void handle(Event event)
	{
		switch (event.type)
		{
		case Event.Type.MouseWheelMoved:
			scroll(event.x, event.y);
			break;
		case Event.Type.MouseMoved:
			move(event.x, event.y, event.xrel, event.yrel);
			break;
		case Event.Type.MouseButtonPressed:
			if (event.x != x || event.y != y)
				moveTo(event.x, event.y);
			click(event.mousebutton, true);
			break;
		case Event.Type.MouseButtonReleased:
			if (event.x != x || event.y != y)
				moveTo(event.x, event.y);
			click(event.mousebutton, false);
			break;
		default:
			break;
		}
	}
}
