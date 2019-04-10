module d2d.rendering.spritesheet;

import std.algorithm;
import std.conv;
import std.file : read;
import std.path;

import d2d.rendering.texture;

import crunch;

struct Spritesheet
{
	Texture[] textures;
	Crunch sprites;

	version (BindSDL_Image) void load(string path)
	{
		load(cast(ubyte[]) read(path), dirName(path));
	}

	version (BindSDL_Image) void load(ubyte[] data, string cwd)
	{
		sprites = crunchFromCompact(data, false);
		textures.length = sprites.textures.length;

		foreach (i, tex; sprites.textures)
			textures[i] = new Texture(buildPath(cwd, tex.name ~ ".png"), TextureFilterMode.Nearest,
					TextureFilterMode.Nearest, TextureClampMode.ClampToEdge, TextureClampMode.ClampToEdge);
	}

	auto buildLookup(Names...)(int texture)
	{
		static immutable string[] names = buildNameList!Names;
		union Data
		{
			mixin(buildLookupStructCode(names));
			Crunch.Image[names.length] images;
		}

		Data ret;
		int index = 0;
		int texIndex = 0;
		while (index < names.length && texIndex < sprites.textures[texture].images.length)
		{
			if (sprites.textures[texture].images[texIndex].name == names[index])
			{
				ret.images[index] = sprites.textures[texture].images[texIndex];
				index++;
			}
			texIndex++;
		}
		if (index != names.length)
			throw new Exception(
					"Not all images loaded! Got " ~ index.to!string ~ " out of " ~ names.length.to!string);
		return ret.lookup;
	}
}

private string[] buildNameList(Names...)()
{
	string[] ret = [Names];
	ret.sort!"a<b";
	return ret;
}

private string buildLookupStructCode(in string[] names)
{
	string ret = "struct Lookup {";
	foreach (string name; names)
		ret ~= "Crunch.Image " ~ name ~ ";";
	ret ~= "} Lookup lookup;";
	return ret;
}
