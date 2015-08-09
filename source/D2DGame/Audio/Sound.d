module D2DGame.Audio.Sound;

import D2D;

/// Thin wrap around Mix_Chunk including loading [FLAC, MikMod, Ogg Vorbis, MP3, Wav] using SDL_Mixer.
class Sound : IVerifiable, IDisposable
{
	private Mix_Chunk* _handle;

	/// Handle to the `Mix_Chunk*`.
	public @property Mix_Chunk* handle()
	{
		return _handle;
	}

	/// Checks if the handle is not null.
	public @property bool valid()
	{
		return _handle !is null;
	}

	private this(Mix_Chunk * handle)
	{
		_handle = handle;
	}

	/// Loads a sound file
	public this(string path)
	{
		// Confusing name, this can load any format
		_handle = Mix_LoadWAV(path.toStringz());
	}

	public ~this()
	{
		dispose();
	}

	/// Creates sound from a `Mix_Chunk*`.
	public static Sound fromChunk(Mix_Chunk* chunk)
	{
		return new Sound(chunk);
	}

	public static bool load()
	{
		return Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 4096) == 0;
	}

	/// Returns the latest sound related error
	public static @property string error()
	{
		return cast(string) Mix_GetError().fromStringz();
	}

	/// Deallocates the memory and invalidates `this`.
	public void dispose()
	{
		if (valid)
		{
			Mix_FreeChunk(_handle);
			_handle = null;
		}
	}

	/// Plays this sound in the selected channel.
	/// Params:
	///     loops: -1 loops will play forever. 0 plays once.
	///     channel: -1 loops will choose the first free unreserved channel.
	///     maxTicks: Maximum milliseconds to play this sound. If not enough loops or the sample chunk is not long enough, then the sample may stop before this timeout occurs. -1 means play forever.
	/// Returns: the channel the sample is played on. On any errors, -1 is returned.
	public int play(int loops = 0, int channel = -1, int maxTicks = -1)
	{
		return Mix_PlayChannelTimed(channel, _handle, loops, maxTicks);
	}

	/// Plays this sound in the selected channel with a fade in effect.
	/// Params:
	///     ms: Milliseconds for the fade-in effect to complete.
	///     loops: -1 loops will play forever. 0 plays once.
	///     channel: -1 loops will choose the first free unreserved channel.
	///     maxTicks: Maximum milliseconds to play this sound. If not enough loops or the sample chunk is not long enough, then the sample may stop before this timeout occurs. -1 means play forever.
	/// Returns: the channel the sample is played on. On any errors, -1 is returned.
	public int fadeIn(int ms, int loops = 1, int channel = -1, int maxTicks = -1)
	{
		return Mix_FadeInChannelTimed(channel, _handle, loops, ms, maxTicks);
	}

	/// Halt playback of sound. This interrupts sound fader effects.
	/// Params:
	///     channel: Channel to stop playing, or -1 for all channels.
	public static void stop(int channel = -1)
	{
		Mix_HaltChannel(channel);
	}

	/// Pause the sound playback. You may halt paused sounds.
	/// Params:
	///     channel: Channel to stop playing, or -1 for all channels.
	/// Note: Sound can only be paused if it is actively playing.
	public static void pause(int channel = -1)
	{
		Mix_Pause(channel);
	}

	/// Unpause the sound. This is safe to use on halted, paused, and already playing sounds.
	/// Params:
	///     channel: Channel to stop playing, or -1 for all channels.
	public static void resume(int channel = -1)
	{
		Mix_Resume(channel);
	}

	/// Returns the current volume as float in range 0.0 to 1.0
	/// Params:
	///     channel: -1 for all channels.
	public static float getVolume(int channel = -1)
	{
		return Mix_Volume(channel, -1) * INV_MIX_MAX_VOLUME;
	}

	/// Sets the current volume as float in range 0.0 to 1.0
	/// Params:
	///     channel: -1 for all channels.
	public static void setVolume(float value, int channel = -1)
	{
		Mix_Volume(channel, cast(int) (value * MIX_MAX_VOLUME));
	}

	/// Tells you how many channels are playing if set to -1
	/// Params:
	///     channel: -1 for all channels.
	public static @property int isPlaying(int channel = -1)
	{
		return Mix_Playing(channel);
	}

	/// Tells you how many channels are paused if set to -1
	/// Params:
	///     channel: -1 for all channels.
	public static @property int isPaused(int channel = -1)
	{
		return Mix_Paused(channel);
	}

	///
	/// Params:
	///     channel: -1 is invalid.
	public static @property FadingStatus fadingStatus(int channel)
	{
		assert(channel != -1);
		return cast(FadingStatus) Mix_FadingChannel(channel);
	}
}
