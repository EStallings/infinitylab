/* -*- dart -*- */
import 'dart:html';
import '../lib/pixi.dart';
import 'Screen.dart';

class Asset {
  static const TEST = const Asset._(0);
  static const TEST2 = const Asset._(1);
  static const SPLASHLOGO = const Asset._(2);
  static get values => [TEST, TEST2, SPLASHLOGO];

  final int value;
  const Asset._(this.value);
}

class FontAsset {
  static const COMICBULLSHIT = const FontAsset._(0);
  static get values => [COMICBULLSHIT];

  final int value;
  const FontAsset._(this.value);
}

class AssetManager {
  static Map _sprites;
  static Map _fonts = new Map();
  static bool _initialized = false;

  _AssetManager() {
    throw "AssetManager(): AssetManager cannot be instantiated!\n";
  }

  static Sprite getSprite(Asset a) {
    if (!_initialized) {
      throw "AssetManager.getSprite(): AssetManager not initialized!\n";
    }
    return _sprites[a];
  }

  static BitmapText renderStr(String str, FontAsset font) {
    BitmapText bt = null;
    try {
      bt = new BitmapText(str, new TextStyle(font: _fonts[font]));
      print("Text <" + str + "> rendered!\n");
    } catch (Exception) {
      print("AssetManager.renderStr: Cannot render text!\n");
    }
    return bt;
  }

  static void init() {
    if (_initialized) {
      throw "AssetManager.init(): AssetManager already initialized!\n";
    }
    _initSprites();
    _initFonts();
    _initialized = true;
  }

  static void _loadFont(FontAsset asset, String fontName, int fontSize) {
    AsssetLoadr l = new AssetLoader(["../fnt/" + fontName.toLowerCase() + ".fnt"])
      ..onComplete.listen((c) {
        _fonts.putIfAbsent(asset, () => fontSize.toString() + "px " + fontName);
      })
      ..load();
  }

  static void _initFonts() {
    _loadFont(FontAsset.COMICBULLSHIT, "Desyrel", 128);
  }

  static void _initSprites() {
    _sprites = {
      Asset.TEST: new Sprite.fromImage("img/test.png"),
      Asset.TEST2: new Sprite.fromImage("img/test2.png"),
      Asset.SPLASHLOGO: new Sprite.fromImage("img/splashlogo.png")
    };
  }
}
