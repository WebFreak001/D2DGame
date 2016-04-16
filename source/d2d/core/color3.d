module d2d.core.color3;

import d2d;

/// Class containing aliases for each different HTML Color converted to floats.
class Color3
{
	/// HTML Color: <span style='background-color: AliceBlue;'>AliceBlue</span>
	alias AliceBlue = AliasSeq!(0.9411764705882353, 0.9725490196078431, 1);
	/// HTML Color: <span style='background-color: AntiqueWhite;'>AntiqueWhite</span>
	alias AntiqueWhite = AliasSeq!(0.9803921568627451, 0.9215686274509803, 0.8431372549019608);
	/// HTML Color: <span style='background-color: Aqua;'>Aqua</span>
	alias Aqua = AliasSeq!(0, 1, 1);
	/// HTML Color: <span style='background-color: Aquamarine;'>Aquamarine</span>
	alias Aquamarine = AliasSeq!(0.4980392156862745, 1, 0.8313725490196079);
	/// HTML Color: <span style='background-color: Azure;'>Azure</span>
	alias Azure = AliasSeq!(0.9411764705882353, 1, 1);
	/// HTML Color: <span style='background-color: Beige;'>Beige</span>
	alias Beige = AliasSeq!(0.9607843137254902, 0.9607843137254902, 0.8627450980392157);
	/// HTML Color: <span style='background-color: Bisque;'>Bisque</span>
	alias Bisque = AliasSeq!(1, 0.8941176470588236, 0.7686274509803922);
	/// HTML Color: <span style='background-color: Black; color: White;'>Black</span>
	alias Black = AliasSeq!(0, 0, 0);
	/// HTML Color: <span style='background-color: BlanchedAlmond;'>BlanchedAlmond</span>
	alias BlanchedAlmond = AliasSeq!(1, 0.9215686274509803, 0.803921568627451);
	/// HTML Color: <span style='background-color: Blue; color: White;'>Blue</span>
	alias Blue = AliasSeq!(0, 0, 1);
	/// HTML Color: <span style='background-color: BlueViolet;'>BlueViolet</span>
	alias BlueViolet = AliasSeq!(0.5411764705882353, 0.16862745098039217, 0.8862745098039215);
	/// HTML Color: <span style='background-color: Brown;'>Brown</span>
	alias Brown = AliasSeq!(0.6470588235294118, 0.16470588235294117, 0.16470588235294117);
	/// HTML Color: <span style='background-color: BurlyWood;'>BurlyWood</span>
	alias BurlyWood = AliasSeq!(0.8705882352941177, 0.7215686274509804, 0.5294117647058824);
	/// HTML Color: <span style='background-color: CadetBlue;'>CadetBlue</span>
	alias CadetBlue = AliasSeq!(0.37254901960784315, 0.6196078431372549, 0.6274509803921569);
	/// HTML Color: <span style='background-color: Chartreuse;'>Chartreuse</span>
	alias Chartreuse = AliasSeq!(0.4980392156862745, 1, 0);
	/// HTML Color: <span style='background-color: Chocolate;'>Chocolate</span>
	alias Chocolate = AliasSeq!(0.8235294117647058, 0.4117647058823529, 0.11764705882352941);
	/// HTML Color: <span style='background-color: Coral;'>Coral</span>
	alias Coral = AliasSeq!(1, 0.4980392156862745, 0.3137254901960784);
	/// HTML Color: <span style='background-color: CornflowerBlue;'>CornflowerBlue</span>
	alias CornflowerBlue = AliasSeq!(0.39215686274509803, 0.5843137254901961, 0.9294117647058824);
	/// HTML Color: <span style='background-color: Cornsilk;'>Cornsilk</span>
	alias Cornsilk = AliasSeq!(1, 0.9725490196078431, 0.8627450980392157);
	/// HTML Color: <span style='background-color: Crimson;'>Crimson</span>
	alias Crimson = AliasSeq!(0.8627450980392157, 0.0784313725490196, 0.23529411764705882);
	/// HTML Color: <span style='background-color: Cyan;'>Cyan</span>
	alias Cyan = AliasSeq!(0, 1, 1);
	/// HTML Color: <span style='background-color: DarkBlue;'>DarkBlue</span>
	alias DarkBlue = AliasSeq!(0, 0, 0.5450980392156862);
	/// HTML Color: <span style='background-color: DarkCyan;'>DarkCyan</span>
	alias DarkCyan = AliasSeq!(0, 0.5450980392156862, 0.5450980392156862);
	/// HTML Color: <span style='background-color: DarkGoldenRod;'>DarkGoldenRod</span>
	alias DarkGoldenRod = AliasSeq!(0.7215686274509804, 0.5254901960784314, 0.043137254901960784);
	/// HTML Color: <span style='background-color: DarkGray;'>DarkGray</span>
	alias DarkGray = AliasSeq!(0.6627450980392157, 0.6627450980392157, 0.6627450980392157);
	/// HTML Color: <span style='background-color: DarkGreen;'>DarkGreen</span>
	alias DarkGreen = AliasSeq!(0, 0.39215686274509803, 0);
	/// HTML Color: <span style='background-color: DarkKhaki;'>DarkKhaki</span>
	alias DarkKhaki = AliasSeq!(0.7411764705882353, 0.7176470588235294, 0.4196078431372549);
	/// HTML Color: <span style='background-color: DarkMagenta;'>DarkMagenta</span>
	alias DarkMagenta = AliasSeq!(0.5450980392156862, 0, 0.5450980392156862);
	/// HTML Color: <span style='background-color: DarkOliveGreen;'>DarkOliveGreen</span>
	alias DarkOliveGreen = AliasSeq!(0.3333333333333333, 0.4196078431372549, 0.1843137254901961);
	/// HTML Color: <span style='background-color: DarkOrange;'>DarkOrange</span>
	alias DarkOrange = AliasSeq!(1, 0.5490196078431373, 0);
	/// HTML Color: <span style='background-color: DarkOrchid;'>DarkOrchid</span>
	alias DarkOrchid = AliasSeq!(0.6, 0.19607843137254902, 0.8);
	/// HTML Color: <span style='background-color: DarkRed;'>DarkRed</span>
	alias DarkRed = AliasSeq!(0.5450980392156862, 0, 0);
	/// HTML Color: <span style='background-color: DarkSalmon;'>DarkSalmon</span>
	alias DarkSalmon = AliasSeq!(0.9137254901960784, 0.5882352941176471, 0.47843137254901963);
	/// HTML Color: <span style='background-color: DarkSeaGreen;'>DarkSeaGreen</span>
	alias DarkSeaGreen = AliasSeq!(0.5607843137254902, 0.7372549019607844, 0.5607843137254902);
	/// HTML Color: <span style='background-color: DarkSlateBlue;'>DarkSlateBlue</span>
	alias DarkSlateBlue = AliasSeq!(0.2823529411764706, 0.23921568627450981, 0.5450980392156862);
	/// HTML Color: <span style='background-color: DarkSlateGray;'>DarkSlateGray</span>
	alias DarkSlateGray = AliasSeq!(0.1843137254901961, 0.30980392156862746, 0.30980392156862746);
	/// HTML Color: <span style='background-color: DarkTurquoise;'>DarkTurquoise</span>
	alias DarkTurquoise = AliasSeq!(0, 0.807843137254902, 0.8196078431372549);
	/// HTML Color: <span style='background-color: DarkViolet;'>DarkViolet</span>
	alias DarkViolet = AliasSeq!(0.5803921568627451, 0, 0.8274509803921568);
	/// HTML Color: <span style='background-color: DeepPink;'>DeepPink</span>
	alias DeepPink = AliasSeq!(1, 0.0784313725490196, 0.5764705882352941);
	/// HTML Color: <span style='background-color: DeepSkyBlue;'>DeepSkyBlue</span>
	alias DeepSkyBlue = AliasSeq!(0, 0.7490196078431373, 1);
	/// HTML Color: <span style='background-color: DimGray;'>DimGray</span>
	alias DimGray = AliasSeq!(0.4117647058823529, 0.4117647058823529, 0.4117647058823529);
	/// HTML Color: <span style='background-color: DodgerBlue;'>DodgerBlue</span>
	alias DodgerBlue = AliasSeq!(0.11764705882352941, 0.5647058823529412, 1);
	/// HTML Color: <span style='background-color: FireBrick;'>FireBrick</span>
	alias FireBrick = AliasSeq!(0.6980392156862745, 0.13333333333333333, 0.13333333333333333);
	/// HTML Color: <span style='background-color: FloralWhite;'>FloralWhite</span>
	alias FloralWhite = AliasSeq!(1, 0.9803921568627451, 0.9411764705882353);
	/// HTML Color: <span style='background-color: ForestGreen;'>ForestGreen</span>
	alias ForestGreen = AliasSeq!(0.13333333333333333, 0.5450980392156862, 0.13333333333333333);
	/// HTML Color: <span style='background-color: Fuchsia;'>Fuchsia</span>
	alias Fuchsia = AliasSeq!(1, 0, 1);
	/// HTML Color: <span style='background-color: Gainsboro;'>Gainsboro</span>
	alias Gainsboro = AliasSeq!(0.8627450980392157, 0.8627450980392157, 0.8627450980392157);
	/// HTML Color: <span style='background-color: GhostWhite;'>GhostWhite</span>
	alias GhostWhite = AliasSeq!(0.9725490196078431, 0.9725490196078431, 1);
	/// HTML Color: <span style='background-color: Gold;'>Gold</span>
	alias Gold = AliasSeq!(1, 0.8431372549019608, 0);
	/// HTML Color: <span style='background-color: GoldenRod;'>GoldenRod</span>
	alias GoldenRod = AliasSeq!(0.8549019607843137, 0.6470588235294118, 0.12549019607843137);
	/// HTML Color: <span style='background-color: Gray;'>Gray</span>
	alias Gray = AliasSeq!(0.5019607843137255, 0.5019607843137255, 0.5019607843137255);
	/// HTML Color: <span style='background-color: Green; color: White;'>Green</span>
	alias Green = AliasSeq!(0, 0.5019607843137255, 0);
	/// HTML Color: <span style='background-color: GreenYellow;'>GreenYellow</span>
	alias GreenYellow = AliasSeq!(0.6784313725490196, 1, 0.1843137254901961);
	/// HTML Color: <span style='background-color: HoneyDew;'>HoneyDew</span>
	alias HoneyDew = AliasSeq!(0.9411764705882353, 1, 0.9411764705882353);
	/// HTML Color: <span style='background-color: HotPink;'>HotPink</span>
	alias HotPink = AliasSeq!(1, 0.4117647058823529, 0.7058823529411765);
	/// HTML Color: <span style='background-color: IndianRed;'>IndianRed</span>
	alias IndianRed = AliasSeq!(0.803921568627451, 0.3607843137254902, 0.3607843137254902);
	/// HTML Color: <span style='background-color: Indigo; color: White;'>Indigo</span>
	alias Indigo = AliasSeq!(0.29411764705882354, 0, 0.5098039215686274);
	/// HTML Color: <span style='background-color: Ivory;'>Ivory</span>
	alias Ivory = AliasSeq!(1, 1, 0.9411764705882353);
	/// HTML Color: <span style='background-color: Khaki;'>Khaki</span>
	alias Khaki = AliasSeq!(0.9411764705882353, 0.9019607843137255, 0.5490196078431373);
	/// HTML Color: <span style='background-color: Lavender;'>Lavender</span>
	alias Lavender = AliasSeq!(0.9019607843137255, 0.9019607843137255, 0.9803921568627451);
	/// HTML Color: <span style='background-color: LavenderBlush;'>LavenderBlush</span>
	alias LavenderBlush = AliasSeq!(1, 0.9411764705882353, 0.9607843137254902);
	/// HTML Color: <span style='background-color: LawnGreen;'>LawnGreen</span>
	alias LawnGreen = AliasSeq!(0.48627450980392156, 0.9882352941176471, 0);
	/// HTML Color: <span style='background-color: LemonChiffon;'>LemonChiffon</span>
	alias LemonChiffon = AliasSeq!(1, 0.9803921568627451, 0.803921568627451);
	/// HTML Color: <span style='background-color: LightBlue;'>LightBlue</span>
	alias LightBlue = AliasSeq!(0.6784313725490196, 0.8470588235294118, 0.9019607843137255);
	/// HTML Color: <span style='background-color: LightCoral;'>LightCoral</span>
	alias LightCoral = AliasSeq!(0.9411764705882353, 0.5019607843137255, 0.5019607843137255);
	/// HTML Color: <span style='background-color: LightCyan;'>LightCyan</span>
	alias LightCyan = AliasSeq!(0.8784313725490196, 1, 1);
	/// HTML Color: <span style='background-color: LightGoldenRodYellow;'>LightGoldenRodYellow</span>
	alias LightGoldenRodYellow = AliasSeq!(0.9803921568627451, 0.9803921568627451, 0.8235294117647058);
	/// HTML Color: <span style='background-color: LightGray;'>LightGray</span>
	alias LightGray = AliasSeq!(0.8274509803921568, 0.8274509803921568, 0.8274509803921568);
	/// HTML Color: <span style='background-color: LightGreen;'>LightGreen</span>
	alias LightGreen = AliasSeq!(0.5647058823529412, 0.9333333333333333, 0.5647058823529412);
	/// HTML Color: <span style='background-color: LightPink;'>LightPink</span>
	alias LightPink = AliasSeq!(1, 0.7137254901960784, 0.7568627450980392);
	/// HTML Color: <span style='background-color: LightSalmon;'>LightSalmon</span>
	alias LightSalmon = AliasSeq!(1, 0.6274509803921569, 0.47843137254901963);
	/// HTML Color: <span style='background-color: LightSeaGreen;'>LightSeaGreen</span>
	alias LightSeaGreen = AliasSeq!(0.12549019607843137, 0.6980392156862745, 0.6666666666666666);
	/// HTML Color: <span style='background-color: LightSkyBlue;'>LightSkyBlue</span>
	alias LightSkyBlue = AliasSeq!(0.5294117647058824, 0.807843137254902, 0.9803921568627451);
	/// HTML Color: <span style='background-color: LightSlateGray;'>LightSlateGray</span>
	alias LightSlateGray = AliasSeq!(0.4666666666666667, 0.5333333333333333, 0.6);
	/// HTML Color: <span style='background-color: LightSteelBlue;'>LightSteelBlue</span>
	alias LightSteelBlue = AliasSeq!(0.6901960784313725, 0.7686274509803922, 0.8705882352941177);
	/// HTML Color: <span style='background-color: LightYellow;'>LightYellow</span>
	alias LightYellow = AliasSeq!(1, 1, 0.8784313725490196);
	/// HTML Color: <span style='background-color: Lime;'>Lime</span>
	alias Lime = AliasSeq!(0, 1, 0);
	/// HTML Color: <span style='background-color: LimeGreen;'>LimeGreen</span>
	alias LimeGreen = AliasSeq!(0.19607843137254902, 0.803921568627451, 0.19607843137254902);
	/// HTML Color: <span style='background-color: Linen;'>Linen</span>
	alias Linen = AliasSeq!(0.9803921568627451, 0.9411764705882353, 0.9019607843137255);
	/// HTML Color: <span style='background-color: Magenta;'>Magenta</span>
	alias Magenta = AliasSeq!(1, 0, 1);
	/// HTML Color: <span style='background-color: Maroon; color: White;'>Maroon</span>
	alias Maroon = AliasSeq!(0.5019607843137255, 0, 0);
	/// HTML Color: <span style='background-color: MediumAquaMarine; color: White;'>MediumAquaMarine</span>
	alias MediumAquaMarine = AliasSeq!(0.4, 0.803921568627451, 0.6666666666666666);
	/// HTML Color: <span style='background-color: MediumBlue; color: White;'>MediumBlue</span>
	alias MediumBlue = AliasSeq!(0, 0, 0.803921568627451);
	/// HTML Color: <span style='background-color: MediumOrchid; color: White;'>MediumOrchid</span>
	alias MediumOrchid = AliasSeq!(0.7294117647058823, 0.3333333333333333, 0.8274509803921568);
	/// HTML Color: <span style='background-color: MediumPurple; color: White;'>MediumPurple</span>
	alias MediumPurple = AliasSeq!(0.5764705882352941, 0.4392156862745098, 0.8588235294117647);
	/// HTML Color: <span style='background-color: MediumSeaGreen; color: White;'>MediumSeaGreen</span>
	alias MediumSeaGreen = AliasSeq!(0.23529411764705882, 0.7019607843137254, 0.44313725490196076);
	/// HTML Color: <span style='background-color: MediumSlateBlue; color: White;'>MediumSlateBlue</span>
	alias MediumSlateBlue = AliasSeq!(0.4823529411764706, 0.40784313725490196, 0.9333333333333333);
	/// HTML Color: <span style='background-color: MediumSpringGreen; color: White;'>MediumSpringGreen</span>
	alias MediumSpringGreen = AliasSeq!(0, 0.9803921568627451, 0.6039215686274509);
	/// HTML Color: <span style='background-color: MediumTurquoise; color: White;'>MediumTurquoise</span>
	alias MediumTurquoise = AliasSeq!(0.2823529411764706, 0.8196078431372549, 0.8);
	/// HTML Color: <span style='background-color: MediumVioletRed; color: White;'>MediumVioletRed</span>
	alias MediumVioletRed = AliasSeq!(0.7803921568627451, 0.08235294117647059, 0.5215686274509804);
	/// HTML Color: <span style='background-color: MidnightBlue; color: White;'>MidnightBlue</span>
	alias MidnightBlue = AliasSeq!(0.09803921568627451, 0.09803921568627451, 0.4392156862745098);
	/// HTML Color: <span style='background-color: MintCream;'>MintCream</span>
	alias MintCream = AliasSeq!(0.9607843137254902, 1, 0.9803921568627451);
	/// HTML Color: <span style='background-color: MistyRose;'>MistyRose</span>
	alias MistyRose = AliasSeq!(1, 0.8941176470588236, 0.8823529411764706);
	/// HTML Color: <span style='background-color: Moccasin;'>Moccasin</span>
	alias Moccasin = AliasSeq!(1, 0.8941176470588236, 0.7098039215686275);
	/// HTML Color: <span style='background-color: NavajoWhite;'>NavajoWhite</span>
	alias NavajoWhite = AliasSeq!(1, 0.8705882352941177, 0.6784313725490196);
	/// HTML Color: <span style='background-color: Navy; color: White;'>Navy</span>
	alias Navy = AliasSeq!(0, 0, 0.5019607843137255);
	/// HTML Color: <span style='background-color: OldLace;'>OldLace</span>
	alias OldLace = AliasSeq!(0.9921568627450981, 0.9607843137254902, 0.9019607843137255);
	/// HTML Color: <span style='background-color: Olive;'>Olive</span>
	alias Olive = AliasSeq!(0.5019607843137255, 0.5019607843137255, 0);
	/// HTML Color: <span style='background-color: OliveDrab;'>OliveDrab</span>
	alias OliveDrab = AliasSeq!(0.4196078431372549, 0.5568627450980392, 0.13725490196078433);
	/// HTML Color: <span style='background-color: Orange;'>Orange</span>
	alias Orange = AliasSeq!(1, 0.6470588235294118, 0);
	/// HTML Color: <span style='background-color: OrangeRed;'>OrangeRed</span>
	alias OrangeRed = AliasSeq!(1, 0.27058823529411763, 0);
	/// HTML Color: <span style='background-color: Orchid;'>Orchid</span>
	alias Orchid = AliasSeq!(0.8549019607843137, 0.4392156862745098, 0.8392156862745098);
	/// HTML Color: <span style='background-color: PaleGoldenRod;'>PaleGoldenRod</span>
	alias PaleGoldenRod = AliasSeq!(0.9333333333333333, 0.9098039215686274, 0.6666666666666666);
	/// HTML Color: <span style='background-color: PaleGreen;'>PaleGreen</span>
	alias PaleGreen = AliasSeq!(0.596078431372549, 0.984313725490196, 0.596078431372549);
	/// HTML Color: <span style='background-color: PaleTurquoise;'>PaleTurquoise</span>
	alias PaleTurquoise = AliasSeq!(0.6862745098039216, 0.9333333333333333, 0.9333333333333333);
	/// HTML Color: <span style='background-color: PaleVioletRed;'>PaleVioletRed</span>
	alias PaleVioletRed = AliasSeq!(0.8588235294117647, 0.4392156862745098, 0.5764705882352941);
	/// HTML Color: <span style='background-color: PapayaWhip;'>PapayaWhip</span>
	alias PapayaWhip = AliasSeq!(1, 0.9372549019607843, 0.8352941176470589);
	/// HTML Color: <span style='background-color: PeachPuff;'>PeachPuff</span>
	alias PeachPuff = AliasSeq!(1, 0.8549019607843137, 0.7254901960784313);
	/// HTML Color: <span style='background-color: Peru;'>Peru</span>
	alias Peru = AliasSeq!(0.803921568627451, 0.5215686274509804, 0.24705882352941178);
	/// HTML Color: <span style='background-color: Pink;'>Pink</span>
	alias Pink = AliasSeq!(1, 0.7529411764705882, 0.796078431372549);
	/// HTML Color: <span style='background-color: Plum;'>Plum</span>
	alias Plum = AliasSeq!(0.8666666666666667, 0.6274509803921569, 0.8666666666666667);
	/// HTML Color: <span style='background-color: PowderBlue;'>PowderBlue</span>
	alias PowderBlue = AliasSeq!(0.6901960784313725, 0.8784313725490196, 0.9019607843137255);
	/// HTML Color: <span style='background-color: Purple; color: White;'>Purple</span>
	alias Purple = AliasSeq!(0.5019607843137255, 0, 0.5019607843137255);
	/// HTML Color: <span style='background-color: RebeccaPurple; color: White;'>RebeccaPurple</span>
	alias RebeccaPurple = AliasSeq!(0.4, 0.2, 0.6);
	/// HTML Color: <span style='background-color: Red; color: White;'>Red</span>
	alias Red = AliasSeq!(1, 0, 0);
	/// HTML Color: <span style='background-color: RosyBrown;'>RosyBrown</span>
	alias RosyBrown = AliasSeq!(0.7372549019607844, 0.5607843137254902, 0.5607843137254902);
	/// HTML Color: <span style='background-color: RoyalBlue;'>RoyalBlue</span>
	alias RoyalBlue = AliasSeq!(0.2549019607843137, 0.4117647058823529, 0.8823529411764706);
	/// HTML Color: <span style='background-color: SaddleBrown;'>SaddleBrown</span>
	alias SaddleBrown = AliasSeq!(0.5450980392156862, 0.27058823529411763, 0.07450980392156863);
	/// HTML Color: <span style='background-color: Salmon;'>Salmon</span>
	alias Salmon = AliasSeq!(0.9803921568627451, 0.5019607843137255, 0.4470588235294118);
	/// HTML Color: <span style='background-color: SandyBrown;'>SandyBrown</span>
	alias SandyBrown = AliasSeq!(0.9568627450980393, 0.6431372549019608, 0.3764705882352941);
	/// HTML Color: <span style='background-color: SeaGreen;'>SeaGreen</span>
	alias SeaGreen = AliasSeq!(0.1803921568627451, 0.5450980392156862, 0.3411764705882353);
	/// HTML Color: <span style='background-color: SeaShell;'>SeaShell</span>
	alias SeaShell = AliasSeq!(1, 0.9607843137254902, 0.9333333333333333);
	/// HTML Color: <span style='background-color: Sienna;'>Sienna</span>
	alias Sienna = AliasSeq!(0.6274509803921569, 0.3215686274509804, 0.17647058823529413);
	/// HTML Color: <span style='background-color: Silver;'>Silver</span>
	alias Silver = AliasSeq!(0.7529411764705882, 0.7529411764705882, 0.7529411764705882);
	/// HTML Color: <span style='background-color: SkyBlue;'>SkyBlue</span>
	alias SkyBlue = AliasSeq!(0.5294117647058824, 0.807843137254902, 0.9215686274509803);
	/// HTML Color: <span style='background-color: SlateBlue;'>SlateBlue</span>
	alias SlateBlue = AliasSeq!(0.41568627450980394, 0.35294117647058826, 0.803921568627451);
	/// HTML Color: <span style='background-color: SlateGray;'>SlateGray</span>
	alias SlateGray = AliasSeq!(0.4392156862745098, 0.5019607843137255, 0.5647058823529412);
	/// HTML Color: <span style='background-color: Snow;'>Snow</span>
	alias Snow = AliasSeq!(1, 0.9803921568627451, 0.9803921568627451);
	/// HTML Color: <span style='background-color: SpringGreen;'>SpringGreen</span>
	alias SpringGreen = AliasSeq!(0, 1, 0.4980392156862745);
	/// HTML Color: <span style='background-color: SteelBlue;'>SteelBlue</span>
	alias SteelBlue = AliasSeq!(0.27450980392156865, 0.5098039215686274, 0.7058823529411765);
	/// HTML Color: <span style='background-color: Tan;'>Tan</span>
	alias Tan = AliasSeq!(0.8235294117647058, 0.7058823529411765, 0.5490196078431373);
	/// HTML Color: <span style='background-color: Teal;'>Teal</span>
	alias Teal = AliasSeq!(0, 0.5019607843137255, 0.5019607843137255);
	/// HTML Color: <span style='background-color: Thistle;'>Thistle</span>
	alias Thistle = AliasSeq!(0.8470588235294118, 0.7490196078431373, 0.8470588235294118);
	/// HTML Color: <span style='background-color: Tomato;'>Tomato</span>
	alias Tomato = AliasSeq!(1, 0.38823529411764707, 0.2784313725490196);
	/// HTML Color: <span style='background-color: Turquoise;'>Turquoise</span>
	alias Turquoise = AliasSeq!(0.25098039215686274, 0.8784313725490196, 0.8156862745098039);
	/// HTML Color: <span style='background-color: Violet;'>Violet</span>
	alias Violet = AliasSeq!(0.9333333333333333, 0.5098039215686274, 0.9333333333333333);
	/// HTML Color: <span style='background-color: Wheat;'>Wheat</span>
	alias Wheat = AliasSeq!(0.9607843137254902, 0.8705882352941177, 0.7019607843137254);
	/// HTML Color: <span style='background-color: White;'>White</span>
	alias White = AliasSeq!(1, 1, 1);
	/// HTML Color: <span style='background-color: WhiteSmoke;'>WhiteSmoke</span>
	alias WhiteSmoke = AliasSeq!(0.9607843137254902, 0.9607843137254902, 0.9607843137254902);
	/// HTML Color: <span style='background-color: Yellow;'>Yellow</span>
	alias Yellow = AliasSeq!(1, 1, 0);
	/// HTML Color: <span style='background-color: YellowGreen;'>YellowGreen</span>
	alias YellowGreen = AliasSeq!(0.6039215686274509, 0.803921568627451, 0.19607843137254902);
}

/// Color3 can be passed instead of 3 floats.
unittest
{
	import std.format : format;

	string formatColor(float r, float g, float b)
	{
		return format("{%f, %f, %f}", r, g, b);
	}

	assert(formatColor(Color3.White) == formatColor(1, 1, 1));


	import std.stdio : writeln;

	void example(float r, float g, float b, float a)
	{
		writeln(r, ": ", formatColor(g, b, a));
	}

	example(0.4f, Color3.Tomato);
	example(Color3.Yellow, 1.2f);
}
