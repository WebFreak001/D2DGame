# D2DGame
2D Game Engine for Ludum Dare written in D. Its similar to SFML and wraps SDL for rendering etc.

## Documentation
The documentation can be found at [https://d2d.webfreak.org/](https://d2d.webfreak.org/)

## Optional Versions

If you wish to enable several features such as Fonts, Textures, Audio, etc. you may want to enable these version identifiers in your dub recipe:

* `BindSDL_Image` - Enables BMFont, BMText, Bitmap.load
* `BindSDL_Mixer` - Enables Music, Sound
* `BindSDL_TTF` - Enables TTFFont, TTFText

# Note
If your on Ubuntu, run this command to install dependencies packages

```sh
sudo apt install libsdl2-dev libsdl-ttf2-dev libsdl2-mixer-dev libsdl2-image-dev
```
