module d2d.core.quadtree;

import std.algorithm;
import std.conv;
import std.functional;
import std.range;
import std.string;

import gl3n.linalg;

import d2d.core.utils;

struct QuadTree(T, size_t maxObjects, size_t maxDepth, string mapper = "a")
{
	@disable this(this);

	rect bounds;

	static if (maxDepth > 0)
	{
		alias SubTree = QuadTree!(T, maxObjects, maxDepth - 1, mapper);
		///  0 | 1
		/// ---+---
		///  2 | 3
		SubTree*[4] nodes;
	}

	T[] children;

	static rect map(T item)
	{
		return unaryFun!mapper(item);
	}

	void clear()
	{
		static if (maxDepth > 0)
			if (nodes[0]!is null)
				foreach (ref node; nodes)
					{
					node.clear();
					node = null;
				}

		children.length = 0;
	}

	static if (maxDepth > 0)
	{
		private void split()
		{
			const center = bounds.center;

			nodes[0] = new SubTree(rect.dim(0, 0, center));
			nodes[1] = new SubTree(rect.dim(center.x, 0, center));
			nodes[2] = new SubTree(rect.dim(0, center.y, center));
			nodes[3] = new SubTree(rect.dim(center, center));
		}

		bool isSplit() @property const @safe
		{
			return nodes[0]!is null;
		}

		/// Determines in which quadrant a rectangle would fall or -1 if it spans multiple.
		static if (!is(T : rect))
			int getQuadrant(T item)
			{
				return getQuadrant(map(item));
			}

		/// ditto
		int getQuadrant(rect r)
		{
			int index = -1;
			const center = bounds.center;

			const aboveMidpoint = r.y < center.y && r.y + r.height < center.y;
			const belowMidpoint = r.y > center.y && r.y + r.height > center.y;
			const leftOfMidpoint = r.x < center.x && r.x + r.width < center.x;
			const rightOfMidpoint = r.x > center.x && r.x + r.width > center.x;

			if (aboveMidpoint)
			{
				if (leftOfMidpoint)
					index = 0;
				else if (rightOfMidpoint)
					index = 1;
			}
			else if (belowMidpoint)
			{
				if (leftOfMidpoint)
					index = 2;
				else if (rightOfMidpoint)
					index = 3;
			}

			return index;
		}
	}

	void insert(T item)
	{
		static if (maxDepth > 0)
		{
			if (nodes[0]!is null)
			{
				auto index = getQuadrant(item);
				if (index >= 0)
				{
					nodes[index].insert(item);
					return;
				}
			}
		}

		children.assumeSafeAppend() ~= item;

		static if (maxDepth > 0)
		{
			if (children.length > maxObjects)
			{
				if (nodes[0] is null)
					split();

				size_t i;
				while (i < children.length)
				{
					auto index = getQuadrant(children[i]);
					if (index == -1)
						i++;
					else
					{
						auto other = children[i];
						children[i] = children[$ - 1];
						children.length--;
						nodes[index].insert(other);
					}
				}
			}
		}
	}

	bool remove(T item)
	{
		if (item is T.init)
			return false;

		static if (maxDepth > 0)
		{
			if (nodes[0]!is null)
			{
				auto index = getQuadrant(item);
				if (index >= 0)
				{
					auto ret = nodes[index].remove(item);
					if (ret)
						return true;
				}
			}
		}

		foreach (i, child; children)
			if (child is item)
			{
				children[i] = children[$ - 1];
				children.length--;
				return true;
			}

		return false;
	}

	T[] retrieve(rect r, bool exact = true)
	{
		static if (maxDepth > 0)
		{
			auto ret = appender!(T[]);
			if (exact)
				ret.put(children.filter!(a => map(a).intersects(r)));
			else
				ret.put(children);

			if (nodes[0]!is null)
			{
				auto index = getQuadrant(r);
				if (index != -1)
					ret.put(nodes[index].retrieve(r, exact));
				else
					foreach (ref node; nodes)
						ret.put(node.retrieve(r, exact));
			}
			return ret.data;
		}
		else
		{
			if (exact)
				return children.filter!(a => map(a).intersects(r)).array;
			else
				return children;
		}
	}

	string toString() const @safe
	{
		auto ret = appender!string;
		ret.put("quad!");
		ret.put(maxDepth.to!string);

		ret.put("(self: ");
		ret.put(children.length.to!string);
		static if (maxDepth > 0)
			if (isSplit)
				{
				ret.put(",\n");
				ret.put(("NW: " ~ nodes[0].toString()).indent);
				ret.put(",\n");
				ret.put(("NE: " ~ nodes[1].toString()).indent);
				ret.put(",\n");
				ret.put(("SE: " ~ nodes[2].toString()).indent);
				ret.put(",\n");
				ret.put(("SW: " ~ nodes[3].toString()).indent);
			}
		ret.put(")");

		return ret.data;
	}
}

private string indent(string s, string indentation = "\t") @safe
{
	return s.lineSplitter!(KeepTerminator.yes)
		.map!(a => a.length ? indentation ~ a : a)
		.join;
}

unittest
{
	QuadTree!(rect, 2, 5) quadtree;
	quadtree.bounds = rect.dim(800, 600);

	assert(quadtree.retrieve(rect.dim(800, 600)).count == 0);

	quadtree.insert(rect.dim(40, 40, 100, 100));

	assert(quadtree.retrieve(rect.dim(800, 600), false).count == 1);
	assert(quadtree.retrieve(rect.dim(139, 40, 100, 100), false).count == 1);
	assert(quadtree.retrieve(rect.dim(140, 40, 100, 100), false).count == 1);
	assert(quadtree.retrieve(rect.dim(141, 40, 100, 100), false).count == 1);
	assert(quadtree.retrieve(rect.dim(40, 139, 100, 100), false).count == 1);
	assert(quadtree.retrieve(rect.dim(40, 140, 100, 100), false).count == 1);
	assert(quadtree.retrieve(rect.dim(40, 141, 100, 100), false).count == 1);

	assert(quadtree.retrieve(rect.dim(800, 600)).count == 1);
	assert(quadtree.retrieve(rect.dim(139, 40, 100, 100)).count == 1);
	assert(quadtree.retrieve(rect.dim(140, 40, 100, 100)).count == 1);
	assert(quadtree.retrieve(rect.dim(141, 40, 100, 100)).count == 0);
	assert(quadtree.retrieve(rect.dim(40, 139, 100, 100)).count == 1);
	assert(quadtree.retrieve(rect.dim(40, 140, 100, 100)).count == 1);
	assert(quadtree.retrieve(rect.dim(40, 141, 100, 100)).count == 0);

	assert(!quadtree.isSplit);

	quadtree.insert(rect.dim(30, 410, 20, 20));
	assert(!quadtree.isSplit);
	assert(quadtree.retrieve(rect.dim(800, 600), false).count == 2);
	assert(quadtree.retrieve(rect.dim(0, 0, 1, 1), false).count == 2);
	assert(quadtree.retrieve(rect.dim(400, 0, 1, 1), false).count == 2);

	quadtree.insert(rect.dim(410, 10, 20, 20));
	assert(quadtree.isSplit);
	assert(quadtree.retrieve(rect.dim(800, 600), false).count == 3);
	assert(quadtree.retrieve(rect.dim(1, 1, 1, 1), false).count == 1);
	assert(quadtree.retrieve(rect.dim(401, 1, 1, 1), false).count == 1);
	assert(quadtree.retrieve(rect.dim(1, 401, 1, 1), false).count == 1);
	assert(quadtree.retrieve(rect.dim(401, 401, 1, 1), false).count == 0);

	quadtree.insert(rect.dim(390, 390, 20, 20));
	assert(quadtree.retrieve(rect.dim(800, 600), false).count == 4);
	assert(quadtree.retrieve(rect.dim(1, 1, 1, 1), false).count == 2);
	assert(quadtree.retrieve(rect.dim(401, 1, 1, 1), false).count == 2);
	assert(quadtree.retrieve(rect.dim(1, 401, 1, 1), false).count == 2);
	assert(quadtree.retrieve(rect.dim(401, 401, 1, 1), false).count == 1);
}
