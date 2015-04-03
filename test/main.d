import D2D;

Texture shurikenTex;

class Shuriken : RectangleShape
{
	vec2 offs;

	public this(int x, int y, int xa, int ya)
	{
		super();
		texture	 = shurikenTex;
		offs	 = vec2(xa * 0.05f, ya * 0.05f);
		origin	 = vec2(40, 40);
		position = vec2(x, y);
		setSize(vec2(80, 80));
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		move(offs);
		rotate(0.1f);
		super.draw(target, shader);
	}
}

void main()
{
	Window window = new Window(1280, 720);
	shurikenTex = new Texture("res/tex/shuriken.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.LinearMipmapLinear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);

	Shuriken[] shuriken;

	int		   startX, startY;

	Event	   event;
	while (window.isOpen())
	{
		while (window.pollEvent(event))
		{
			switch (event.type)
			{
			case Event.Type.Quit:
				window.close();
				break;
			case Event.Type.MouseButtonPressed:
				startX = event.x;
				startY = event.y;
				break;
			case Event.Type.MouseButtonReleased:
				shuriken ~= new Shuriken(event.x, event.y, event.x - startX, event.y - startY);
				break;
			default:
				break;
			}
		}
		window.clear(Color3.SkyBlue);

		foreach (ref Shuriken s; shuriken)
			window.draw(s);

		window.display();
	}
}
