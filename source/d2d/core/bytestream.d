module d2d.core.bytestream;

public import std.system : Endian;
public import std.bitmanip;
import std.traits;

/// Struct for wrapping a ubyte[] with read functions and endianness.
struct ByteStreamImpl (Endian endianness)
{
	/// Contains the data.
	ubyte[] stream;
	alias stream this;

	/// Sets the stream to data.
	this(ubyte[] data)
	{
		stream = data;
	}

	/// Sets the stream to data.
	void opAssign(ubyte[] data)
	{
		stream = data;
	}

	/// Advances the stream by `amount` bytes.
	void skip(size_t amount)
	{
		stream = stream[amount .. $];
	}

	/// Returns the first `T.sizeof` bytes from the stream and advances the stream.
	T read(T = ubyte)()
	{
		return stream.read!(T, endianness)();
	}

	/// Returns a `T[]` from the stream and advances the stream.
	T[] read(T = ubyte)(size_t length)
	{
		T[] data = new T[length];
		for (size_t i = 0; i < length; i++)
			data[i] = read!(T)();
		return data;
	}

	/// Reads until value is `value` and returns everything read excluding `value`. Advances after found `value`. Returns `null` if `value` was not found.
	T readTo(T)(ubyte value)
	{
		// Check for ForeachType!T.sizeof == 1 maybe?
		static assert(isArray!T, "T must be an Array!");
		for (size_t i = 0; i < stream.length; i++)
		{
			if (stream[i] == value)
			{
				scope (exit) stream = stream[i + 1 .. $];
				return cast(T) stream[0 .. i];
			}
		}
		return cast(T) null;
	}

	/// Reads until value is `value` and returns everything read including `value`. Advances after found `value`. Returns `null` if `value` was not found.
	T readToIncluding(T)(ubyte value)
	{
		// Check for ForeachType!T.sizeof == 1 maybe?
		static assert(isArray!T, "T must be an Array!");
		for (size_t i = 0; i < stream.length; i++)
		{
			if (stream[i] == value)
			{
				scope (exit) stream = stream[i + 1 .. $];
				return cast(T) stream[0 .. i + 1];
			}
		}
		return cast(T) null;
	}

	/// Returns `T.sizeof` bytes from the stream at position `index` without advancing the stream.
	T peek(T = ubyte)(size_t index = 0)
	{
		return stream.peek!(T, endianness)(index);
	}

	/// Returns a `T[]` from the stream.
	T[] peek(T = ubyte)(size_t index, size_t length)
	{
		T[] data = new T[length];
		for (size_t i = 0; i < length; i++)
			data[i] = peek!(T)(index + i * T.sizeof);
		return data;
	}

	/// Writes `data` to the stream at position `index`.
	void write(T)(T data, size_t index)
	{
		static if (isArray!(T))
		{
			for (size_t i = 0; i < data.length; i++)
				write(data[i], index + i * typeof(data[0]).sizeof);
		}
		else
		{
			stream.write!(T, endianness)(data, index);
		}
	}

	/// Appends `data` to the stream.
	void append(T)(T data)
	{
		static if (isArray!(T))
		{
			for (size_t i = 0; i < data.length; i++)
				append(data[i]);
		}
		else
		{
			stream.length += T.sizeof;
			write(data, stream.length - T.sizeof);
		}
	}
}

alias ByteStream = ByteStreamImpl!(Endian.bigEndian);
alias BigByteStream = ByteStream;
alias LittleByteStream = ByteStreamImpl!(Endian.littleEndian);

///
unittest
{
	ByteStream stream = cast(ubyte[])[0x01, 0x05, 0x16, 0x09, 0x2C, 0xFF, 0x08];

	assert(stream.peek!uint () == 0x01_05_16_09);

	stream.append!(ushort[])([0x4A_2B, 0x59_12]);
	assert(stream.read!ulong () == 0x01_05_16_09_2C_FF_08_4AUL);
	assert(stream == [0x2B, 0x59, 0x12]);

	stream.write!ubyte (0x44, 1);
	assert(stream == [0x2B, 0x44, 0x12]);

	stream.write!(ubyte[])([0x01, 0x02, 0x03], 0);
	assert(stream == [0x01, 0x02, 0x03]);
}

///
unittest
{
	ByteStream stream = (cast(ubyte[]) "abc\0") ~cast(ubyte[])[0x44];
	assert(stream.readTo!string(cast(ubyte) '\0') == "abc");
	assert(stream == [0x44]);
}

///
unittest
{
	ByteStream stream = (cast(ubyte[]) "abc\0") ~cast(ubyte[])[0x44];
	assert(stream.readToIncluding!string(cast(ubyte) '\0') == "abc\0");
	assert(stream == [0x44]);
}

unittest
{
	ByteStream stream = cast(ubyte[])[0x01, 0x05, 0x16, 0x09, 0x2C, 0xFF, 0x08];

	assert(stream.peek!uint () == 0x01_05_16_09);
	assert(stream.peek!ushort () == 0x01_05);
	assert(stream.peek!ubyte () == 0x01);

	assert(stream.peek!uint (2) == 0x16_09_2C_FF);
	assert(stream.peek!ushort (2) == 0x16_09);
	assert(stream.peek!ubyte (2) == 0x16);

	assert(stream.peek!ushort (1, 2) == [0x05_16, 0x09_2C]);

	stream ~= 0x4A;

	assert(stream.peek!uint (0, 2) == [0x01_05_16_09, 0x2C_FF_08_4A]);
}

unittest
{
	ByteStream stream = cast(ubyte[])[0x01, 0x05];

	stream.append!ushort (0x4A_2B);
	assert(stream == [0x01, 0x05, 0x4A, 0x2B]);

	stream.append!(ubyte[])(cast(ubyte[])[0x16, 0x09, 0x2C, 0xFF, 0x08]);
	assert(stream == [0x01, 0x05, 0x4A, 0x2B, 0x16, 0x09, 0x2C, 0xFF, 0x08]);
}

unittest
{
	ByteStream stream = cast(ubyte[])[0x01, 0x05, 0x16, 0x09, 0x2C, 0xFF, 0x08];

	stream.write!ubyte (0x06, 1);
	assert(stream == [0x01, 0x06, 0x16, 0x09, 0x2C, 0xFF, 0x08]);

	stream.write!(ushort[])(cast(ushort[])[0x07_4A, 0x2B_EA], 1);
	assert(stream == [0x01, 0x07, 0x4A, 0x2B, 0xEA, 0xFF, 0x08]);
}

unittest
{
	ByteStream stream = cast(ubyte[])[0x01, 0x05, 0x16, 0x09, 0x2C, 0xFF, 0x08];

	assert(stream.read() == 0x01);
	assert(stream.read!ushort () == 0x05_16);
	assert(stream.read!uint () == 0x09_2C_FF_08);
	assert(stream.length == 0);
}
