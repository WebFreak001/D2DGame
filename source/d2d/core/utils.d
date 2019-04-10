module d2d.core.utils;

import gl3n.linalg;

struct Rectangle(T)
{
	alias vec2t = Vector!(T, 2);

	T x = 0, y = 0, width = 0, height = 0;

	vec2t center() const @property nothrow @nogc pure @safe
	{
		return vec2t(x + width / 2, y + height / 2);
	}

	vec2t size() const @property nothrow @nogc pure @safe
	{
		return vec2t(width, height);
	}

	vec2t size(vec2t newSize) @property nothrow @nogc pure @safe
	{
		width = newSize.x;
		height = newSize.y;
		return newSize;
	}

	Rectangle!T normalized() const @property nothrow @nogc pure @safe
	{
		Rectangle!T copy = this;
		if (copy.width < 0)
		{
			copy.x += copy.width;
			copy.width = -copy.width;
		}
		if (copy.height < 0)
		{
			copy.y += copy.height;
			copy.height = -copy.height;
		}
		return copy;
	}

	Rectangle!T scale(vec2t size) const @property nothrow @nogc pure @safe
	{
		return scale(size.x, size.y);
	}

	Rectangle!T scale(T x, T y) const @property nothrow @nogc pure @safe
	{
		return Rectangle!T(this.x * x, this.y * y, width * x, height * y);
	}

	static Rectangle!T dim(T width, T height) nothrow @nogc pure @safe
	{
		return Rectangle!T(0, 0, width, height);
	}

	static Rectangle!T dim(vec2t size) nothrow @nogc pure @safe
	{
		return Rectangle!T(0, 0, size.x, size.y);
	}

	static Rectangle!T dim(T x, T y, T width, T height) nothrow @nogc pure @safe
	{
		return Rectangle!T(x, y, width, height);
	}

	static Rectangle!T dim(vec2t pos, T width, T height) nothrow @nogc pure @safe
	{
		return Rectangle!T(pos.x, pos.y, width, height);
	}

	static Rectangle!T dim(T x, T y, vec2t size) nothrow @nogc pure @safe
	{
		return Rectangle!T(x, y, size.x, size.y);
	}

	static Rectangle!T dim(vec2t pos, vec2t size) nothrow @nogc pure @safe
	{
		return Rectangle!T(pos.x, pos.y, size.x, size.y);
	}

	static Rectangle!T abs(T x1, T y1, T x2, T y2) nothrow @nogc pure @safe
	{
		return Rectangle!T(x1, y1, x2 - x1, y2 - y1);
	}

	static Rectangle!T abs(vec2t pos1, T x2, T y2) nothrow @nogc pure @safe
	{
		return Rectangle!T(pos1.x, pos1.y, x2 - pos1.x, y2 - pos1.y);
	}

	static Rectangle!T abs(T x1, T y1, vec2t pos2) nothrow @nogc pure @safe
	{
		return Rectangle!T(x1, y1, pos2.x - x1, pos2.y - y1);
	}

	static Rectangle!T abs(vec2t pos1, vec2t pos2) nothrow @nogc pure @safe
	{
		return Rectangle!T(pos1.x, pos1.y, pos2.x - pos1.x, pos2.y - pos1.y);
	}

	vec2t pos00() @property const nothrow @nogc pure @safe
	{
		return vec2t(x, y);
	}

	vec2t pos10() @property const nothrow @nogc pure @safe
	{
		return vec2t(x + width, y);
	}

	vec2t pos11() @property const nothrow @nogc pure @safe
	{
		return vec2t(x + width, y + height);
	}

	vec2t pos01() @property const nothrow @nogc pure @safe
	{
		return vec2t(x, y + height);
	}

	Rectangle!T translate(T x, T y) nothrow @nogc pure @safe
	{
		return Rectangle!T(this.x + x, this.y + y, width, height);
	}

	Rectangle!T translate(vec2t position) nothrow @nogc pure @safe
	{
		return Rectangle!T(x + position.x, y + position.y, width, height);
	}

	bool intersects(const rect other) nothrow @nogc pure @safe
	{
		return !(x + width < other.x || other.x + other.width < x || y + height < other.y
				|| other.y + other.height < y);
	}
}

alias rect = Rectangle!float;
alias rectd = Rectangle!double;
alias recti = Rectangle!int;
