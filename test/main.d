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
		origin		  = vec2(64, 64);
		this.rotation = rotation;
		rotaSpeed	  = 0.1f * max(0.1f, offs.length * 0.05f);
		position	  = vec2(x, y);
		setSize(vec2(128, 128));
	}

	void update(float delta)
	{
		move(offs * delta * 100);
		rotate(rotaSpeed * delta * 100);
	}

	override void draw(IRenderTarget target, ShaderProgram shader = null)
	{
		matrixStack.push();
		matrixStack.top = matrixStack.top * transform;
		if (texture !is null)
			texture.bind(0);
		shader.bind();
		shader.set("invTransWorld", matrixStack.top.inverse().transposed());
		target.draw(_mesh, shader);
		matrixStack.pop();
	}

	@property bool isIn()
	{
		return position.x > -80 && position.y > -80 && position.x < 1360 && position.y < 800;
	}
}

class Game1 : Game
{
private:
	Shuriken[]	  shuriken;
	Shuriken	  mouse;
	int			  lastX, lastY;
	int			  currentX, currentY;
	bool		  clicked = false;
	ShaderProgram shader;
	Texture		  normal;

public:
	override void init()
	{
		windowWidth	 = 1280;
		windowHeight = 720;
		windowTitle	 = "Shuriken Simulator EXTREME SUPER ULTRA DELUXE EDITION OMEGA 2.WHOA";
		maxFPS		 = 0;
	}

	override void load()
	{
		shurikenTex = new Texture("res/tex/shuriken-color.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);
		mouse		= new Shuriken(0, 0, 0, 0, 0);

		shader = new ShaderProgram();
		shader.attach(Shader.create(ShaderType.Vertex, import ("default.vert")));
		shader.attach(Shader.create(ShaderType.Fragment, import ("normal.frag")));
		shader.link();
		shader.registerUniform("projection");
		shader.registerUniform("transform");
		shader.registerUniform("tex");
		shader.registerUniform("tex2");
		shader.registerUniform("invTransWorld");

		shader.set("tex", 0);
		shader.set("tex2", 1);

		normal = new Texture("res/tex/shuriken-normal.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);
	}

	override void update(float delta)
	{
		for (int i = shuriken.length - 1; i >= 0; i--)
		{
			shuriken[i].update(delta);
			if (!shuriken[i].isIn)
				shuriken = shuriken.remove!(o => o == shuriken[i])();
		}
	}

	override void onEvent(Event event)
	{
		switch (event.type)
		{
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

	override void draw()
	{
		window.clear(Color3.SkyBlue);

		for (int i = shuriken.length - 1; i >= 0; i--)
		{
			normal.bind(1);
			window.draw(shuriken[i], shader);
		}

		if (clicked)
		{
			mouse.position = vec2(currentX, currentY);
			normal.bind(1);
			window.draw(mouse, shader);
		}
	}
}

void main()
{
	new Game1().run();

	/*Window window = new Window(1280, 720);
	   window.setIcon(Bitmap.load("res/shuriken-icon.png"));
	   shurikenTex = new Texture("res/tex/shuriken-color.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);

	   Shuriken[]	  shuriken;
	   Shuriken	  mouse = new Shuriken(0, 0, 0, 0, 0);

	   int			  lastX, lastY;
	   int			  currentX, currentY;
	   bool		  clicked = false;
	   FPSLimiter	  limiter = new FPSLimiter(60);

	   ShaderProgram shader = new ShaderProgram();
	   shader.attach(Shader.create(ShaderType.Vertex, import ("default.vert")));
	   shader.attach(Shader.create(ShaderType.Fragment, import ("normal.frag")));
	   shader.link();
	   shader.registerUniform("projection");
	   shader.registerUniform("transform");
	   shader.registerUniform("tex");
	   shader.registerUniform("tex2");
	   shader.registerUniform("invTransWorld");

	   shader.set("tex", 0);
	   shader.set("tex2", 1);

	   Texture normal = new Texture("res/tex/shuriken-normal.png", TextureFilterMode.LinearMipmapLinear, TextureFilterMode.Linear, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);

	   Event	event;
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
	        normal.bind(1);
	        window.draw(shuriken[i], shader);
	        if (!shuriken[i].isIn)
	            shuriken = shuriken.remove!(o => o == shuriken[i])();
	    }

	    if (clicked)
	    {
	        mouse.position = vec2(currentX, currentY);
	        normal.bind(1);
	        window.draw(mouse, shader);
	    }

	    window.display();

	    limiter.wait();
	   }*/
}
