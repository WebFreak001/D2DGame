module d2d.toolkit.input.keyboard;

import d2d.window.windowevent;

struct Keyboard
{
	@disable this(this);

	bool[256] keys;
	bool[uint] extendedKeys;

	static Keyboard instance;

	Keyboard dup()
	{
		return Keyboard(keys, extendedKeys.dup);
	}

	bool isPressed(int key)
	{
		if (key < keys.length)
			return keys[key];
		else if (auto v = key in extendedKeys)
			return *v;
		else
			return false;
	}

	void keyDown(int key)
	{
		if (key < keys.length)
			keys[key] = true;
		else
			extendedKeys[key] = true;
	}

	void keyUp(int key)
	{
		if (key < keys.length)
			keys[key] = false;
		else
			extendedKeys[key] = false;
	}

	void handle(Event event)
	{
		switch (event.type)
		{
		case Event.Type.KeyPressed:
			keyDown(event.key);
			break;
		case Event.Type.KeyReleased:
			keyUp(event.key);
			break;
		default:
			break;
		}
	}
}
