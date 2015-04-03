import D2D;

import std.algorithm;

Texture shurikenTex;

class Shuriken : RectangleShape
{
	vec2  offs;
	float rotaSpeed = 0;

	public this(int x, int y, int xa, int ya, float rotation)
	{
		super();
		texture = shurikenTex;
		offs	= vec2(xa * 0.5f, ya * 0.5f);
		if (offs.length < 1)
			offs = offs.normalized();
		if (offs.length > 10)
			offs = offs.normalized() * 10;
		origin		  = vec2(40, 40);
		this.rotation = rotation;
		rotaSpeed	  = max(0.1f, offs.length * 0.05f);
		position	  = vec2(x, y);
		setSize(vec2(80, 80));
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		move(offs);
		rotate(rotaSpeed);
		super.draw(target, shader);
	}

	@property bool isIn()
	{
		return position.x > -80 && position.y > -80 && position.x < 1360 && position.y < 800;
	}
}

void main()
{
	Window window = new Window(1280, 720);
	window.setIcon(Bitmap.load("res/shuriken-icon.png"));
	shurikenTex = new Texture("res/tex/shuriken.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);

	Shuriken[] shuriken;
	Shuriken   mouse = new Shuriken(0, 0, 0, 0, 0);

	int		   lastX, lastY;
	int		   currentX, currentY;
	bool	   clicked = false;
	FPSLimiter limiter = new FPSLimiter(60);

	Event	   event;
	while (window.open)
	{
		while (window.pollEvent(event))
		{
			switch (event.type)
			{
			case Event.Type.Quit:
				window.close();
				break;
			case Event.Type.MouseButtonPressed:
				clicked = true;
				break;
			case Event.Type.MouseMoved:
				lastX	 = currentX;
				lastY	 = currentY;
				currentX = event.x;
				currentY = event.y;
				break;
			case Event.Type.MouseButtonReleased:
				clicked = false;
				shuriken ~= new Shuriken(event.x, event.y, event.x - lastX, event.y - lastY, mouse.rotation);
				break;
			default:
				break;
			}
		}
		window.clear(Color3.SkyBlue);

		for (int i = shuriken.length - 1; i >= 0; i--)
		{
			window.draw(shuriken[i]);
			if (!shuriken[i].isIn)
				shuriken = shuriken.remove!(o => o == shuriken[i])();
		}

		if (clicked)
		{
			mouse.position = vec2(currentX, currentY);
			window.draw(mouse);
		}

		window.display();

		limiter.wait();
	}
}
