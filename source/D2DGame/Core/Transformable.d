module D2DGame.Core.Transformable;

import D2D;

/// Base class for Drawables containing code for rotation, scaling and translation around an origin.
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
	/// Rotates this around origin with the specified amount relatively.
	void rotate(float amount)
	{
		_rotation	+= amount;
		_needsChange = true;
	}

	/// Scales this around origin with the specified amount relatively.
	void scale(vec2 amount)
	{
		_scale		+= amount;
		_needsChange = true;
	}

	/// Moves this with the specified amount relatively.
	void move(vec2 amount)
	{
		_position	+= amount;
		_needsChange = true;
	}

 @property:
	/// Calculates the transformation matrix when needed and returns it.
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

	/// Sets the position of this transform.
	void position(vec2 position)
	{
		_position	 = position;
		_needsChange = true;
	}

	/// Gets the position of this transform.
	vec2 position()
	{
		return _position;
	}

	/// Sets the origin position of this transform.
	void origin(vec2 origin)
	{
		_origin		 = origin;
		_needsChange = true;
	}

	/// Gets the origin position of this transform.
	vec2 origin()
	{
		return _origin;
	}

	/// Sets the scaling of this transform.
	void scaling(vec2 scale)
	{
		_scale		 = scale;
		_needsChange = true;
	}

	/// Gets the scaling of this transform.
	vec2 scaling()
	{
		return _scale;
	}

	/// Sets the rotation of this transform.
	void rotation(float rotation)
	{
		_rotation	 = rotation;
		_needsChange = true;
	}

	/// Gets the rotation of this transform.
	float rotation()
	{
		return _rotation;
	}
}
