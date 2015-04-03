module D2DGame.Core.Transformable;

import D2D;

class Transformable
{
private:
	mat4  _transform   = mat4.identity;
	vec2  _origin	   = vec2(0);
	vec2  _position	   = vec2(0);
	vec2  _scale	   = vec2(1);
	float _rotation	   = 0;
	bool  _needsChange = true;
public:
 @nogc:
	void rotate(float amount)
	{
		_rotation	+= amount;
		_needsChange = true;
	}

	void scale(vec2 amount)
	{
		_scale		+= amount;
		_needsChange = true;
	}

	void move(vec2 amount)
	{
		_position	+= amount;
		_needsChange = true;
	}

 @property:
	mat4 transform()
	{
		if (_needsChange)
		{
			_transform = mat4.scaling(_scale.x, _scale.y, 1) * mat4.translation(_position.x, _position.y, 0)
						 * mat4.zrotation(_rotation) * mat4.translation(-_origin.x, -_origin.y, 0);

			assert(_transform.isFinite);
		}

		return _transform;
	}

	void position(vec2 position)
	{
		_position	 = position;
		_needsChange = true;
	}

	vec2 position()
	{
		return _position;
	}

	void origin(vec2 origin)
	{
		_origin		 = origin;
		_needsChange = true;
	}

	vec2 origin()
	{
		return _origin;
	}

	void scale(vec2 scale)
	{
		_scale		 = scale;
		_needsChange = true;
	}

	vec2 scale()
	{
		return _scale;
	}

	void rotation(float rotation)
	{
		_rotation	 = rotation;
		_needsChange = true;
	}

	float rotation()
	{
		return _rotation;
	}
}
