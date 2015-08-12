module d2d.audio.music;

import d2d;

/// 1.0 / MIX_MAX_VOLUME
enum INV_MIX_MAX_VOLUME = 1.0f / MIX_MAX_VOLUME;

///
enum FadingStatus : ubyte
{
	///
	NoFading = MIX_NO_FADING,
	///
	FadingOut = MIX_FADING_OUT,
	///
	FadingIn = MIX_FADING_IN,
}

///
enum MusicType : ubyte
{
	///
	CommandBased = MUS_CMD,
	///
	Wav = MUS_WAV,
	///
	Mod = MUS_MOD,
	///
	ModPlug = MUS_MODPLUG,
	///
	Mid = MUS_MID,
	///
	Ogg = MUS_OGG,
	///
	Mp3 = MUS_MP3,
	///
	Mp3Mad = MUS_MP3_MAD,
	///
	None = MUS_NONE,
}

/// Thin wrap around Mix_Music including loading [FLAC, MikMod, Ogg Vorbis, MP3, Wav] using SDL_Mixer.
class Music : IVerifiable, IDisposable
{
	private Mix_Music* _handle;

	/// Handle to the `Mix_Music*`.
	public @property Mix_Music* handle()
	{
		return _handle;
	}

	/// Checks if the handle is not null.
	public @property bool valid()
	{
		return _handle !is null;
	}

	private this(Mix_Music * handle)
	{
		_handle = handle;
	}

	/// Loads a music file
	public this(string path)
	{
		_handle = Mix_LoadMUS(path.toStringz());
	}

	public ~this()
	{
		dispose();
	}

	/// Creates music from a `Mix_Music*`.
	public static Music fromMusic(Mix_Music* handle)
	{
		return new Music(handle);
	}

	public static bool load()
	{
		return Mix_OpenAudio(44_100, MIX_DEFAULT_FORMAT, 2, 4096) == 0;
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
			Mix_FreeMusic(_handle);
			_handle = null;
		}
	}

	/// Plays this music, will stop other musics. -1 loops will play forever.
	/// Returns: true on success, or false on errors
	public bool play(int loops = 1)
	{
		return Mix_PlayMusic(_handle, loops) == 0;
	}

	/// Starts this music by fading in over `ms` milliseconds, will stop other musics. -1 loops will play forever.
	/// Params:
	///     ms: Milliseconds for the fade-in effect to complete.
	///     loops: -1 loops will play forever. 0 plays the music zero times.
	/// Returns: true on success, or false on errors
	public bool fadeIn(int ms, int loops = 1)
	{
		return Mix_FadeInMusic(_handle, loops, ms) == 0;
	}

	/// Starts this music by fading in over `ms` milliseconds, will stop other musics.
	/// Params:
	///     ms: Milliseconds for the fade-in effect to complete.
	///     loops: -1 loops will play forever. 0 plays the music zero times.
	///     position: Set the position of the currently playing music. The position takes different meanings for different music sources. It only works on the music sources listed below.
	///         <b>MOD</b>
	///             The double is cast to Uint16 and used for a pattern number in the module. Passing zero is similar to rewinding the song.
	///         <b>OGG/MP3</b>
	///             Jumps to position seconds from the beginning of the song.
	/// Returns: true on success, or false on errors
	public bool fadeIn(int ms, int loops, double position)
	{
		return Mix_FadeInMusicPos(_handle, loops, ms, position) == 0;
	}

	///
	public @property MusicType type()
	{
		return cast(MusicType) Mix_GetMusicType(_handle);
	}

	/// Modifies the position where currently playing.
	/// Params:
	///     ms: Milliseconds for the fade-in effect to complete.
	///     loops: -1 loops will play forever. 0 plays the music zero times.
	///     position: Set the position of the currently playing music. The position takes different meanings for different music sources. It only works on the music sources listed below. Will automatically rewind before setting.
	///         <b>MOD</b>
	///             The double is cast to Uint16 and used for a pattern number in the module. Passing zero is similar to rewinding the song.
	///         <b>OGG/MP3</b>
	///             Jumps to position seconds from the beginning of the song.
	/// Returns: true on success, or false if the codec doesn't support this function
	public static @property bool position(double value)
	{
		Mix_RewindMusic();
		return Mix_SetMusicPosition(value) == 0;
	}

	/// Rewinds music to the start. This is safe to use on halted, paused, and already playing music. It is not useful to rewind the music immediately after starting playback, because it starts at the beginning by default.
	public static void rewind()
	{
		Mix_RewindMusic();
	}

	/// Halt playback of music. This interrupts music fader effects.
	public static void stop()
	{
		Mix_RewindMusic();
	}

	/// Pause the music playback. You may halt paused music.
	/// Note: Music can only be paused if it is actively playing.
	public static void pause()
	{
		Mix_PauseMusic();
	}

	/// Unpause the music. This is safe to use on halted, paused, and already playing music.
	public static void resume()
	{
		Mix_ResumeMusic();
	}

	/// Returns the current volume as float in range 0.0 to 1.0
	public static @property float volume()
	{
		return Mix_VolumeMusic(-1) * INV_MIX_MAX_VOLUME;
	}

	/// Sets the current volume as float in range 0.0 to 1.0
	public static @property void volume(float value)
	{
		Mix_VolumeMusic(cast(int) (value * MIX_MAX_VOLUME));
	}

	///
	public static @property bool isPlaying()
	{
		return Mix_PlayingMusic() == 1;
	}

	///
	public static @property bool isPaused()
	{
		return Mix_PausedMusic() == 1;
	}

	///
	public static @property FadingStatus fadingStatus()
	{
		return cast(FadingStatus) Mix_FadingMusic();
	}
}
