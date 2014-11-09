/* -*- dart -*- */
import 'dart:html';
import '../lib/pixi.dart';
import 'Screen.dart';

class Asset {
  static const TEST = const Asset._(0);
  static const TEST2 = const Asset._(1);
  static const SPLASHLOGO = const Asset._(2);
  static const FLOOR_TILE = const Asset._(3);
  static const DOOR_V_OPEN_TILE = const Asset._(4);
  static const DOOR_V_CLOSE_TILE = const Asset._(5);
  static const DOOR_H_OPEN_TILE = const Asset._(6);
  static const DOOR_H_CLOSE_TILE = const Asset._(7);
  static const WALL_NESW_TILE = const Asset._(8);
  static const WALL_ESW_TILE = const Asset._(9);
  static const WALL_NSW_TILE = const Asset._(10);
  static const WALL_NEW_TILE = const Asset._(11);
  static const WALL_NES_TILE = const Asset._(12);
  static const WALL_NE_TILE = const Asset._(13);
  static const WALL_NS_TILE = const Asset._(14);
  static const WALL_NW_TILE = const Asset._(15);
  static const WALL_ES_TILE = const Asset._(16);
  static const WALL_EW_TILE = const Asset._(17);
  static const WALL_SW_TILE = const Asset._(18);
  static const SWITCH_OFF_TILE = const Asset._(19);
  static const SWITCH_ON_TILE = const Asset._(20);
  static get values => [TEST, TEST2, SPLASHLOGO, FLOOR_TILE,
      DOOR_V_OPEN_TILE, DOOR_V_CLOSE_TILE,
      DOOR_H_OPEN_TILE, DOOR_H_CLOSE_TILE, WALL_NESW_TILE, WALL_ESW_TILE,
      WALL_NSW_TILE, WALL_NEW_TILE,
      WALL_NES_TILE, WALL_NE_TILE,
      WALL_NS_TILE, WALL_NW_TILE,
      WALL_ES_TILE, WALL_EW_TILE,
      WALL_SW_TILE, SWITCH_OFF_TILE, SWITCH_ON_TILE];

  final int value;
  const Asset._(this.value);
}

class FontAsset {
  static const COMICBULLSHIT = const FontAsset._(0);
  static const AVENIR = const FontAsset._(1);
  static get values => [COMICBULLSHIT, AVENIR];

  final int value;
  const FontAsset._(this.value);
}

class AssetManager {
  static Map _textures;
  static Map _fonts = new Map();
  static bool _initialized = false;

  _AssetManager() {
    throw "AssetManager(): AssetManager cannot be instantiated!\n";
  }

  static Texture getTexture(Asset a) {
    if (!_initialized) {
      throw "AssetManager.getTexture(): AssetManager not initialized!\n";
    }
    return _textures[a];
  }

  static BitmapText renderStr(String str, FontAsset fasset) {
    BitmapText bt = null;
    try {
      bt = new BitmapText(str, new TextStyle(font: _fonts[fasset]));
    } catch (Exception) {
      print("AssetManager.renderStr: Cannot render text!\n");
    }
    return bt;
  }

  static Sprite getNewSprite(Point pt, Asset asset) {
    Texture t = getTexture(asset);
    Sprite s = new Sprite(t)
      ..position = pt;
    return s;
  }

  static void init() {
    if (_initialized) {
      throw "AssetManager.init(): AssetManager already initialized!\n";
    }
    _initTextures();
    _initFonts();
    _initialized = true;
  }

  static void _loadFont(FontAsset asset, String fontName, int fontSize) {
    AssetLoader l = new AssetLoader(["../fnt/" + fontName.toLowerCase() + ".fnt"])
      ..onComplete.listen((c) {
        _fonts.putIfAbsent(asset, () => fontSize.toString() + "px " + fontName);
      })
      ..load();
  }

  static void _initFonts() {
    _loadFont(FontAsset.COMICBULLSHIT, "Desyrel", 128);
    _loadFont(FontAsset.AVENIR, "Avenir", 128);
  }

  static void _initTextures() {
    _textures = {
      Asset.TEST: new Texture.fromImage("img/test.png"),
      Asset.TEST2: new Texture.fromImage("img/test2.png"),
      Asset.SPLASHLOGO: new Texture.fromImage("img/splashlogo.png"),
      Asset.FLOOR_TILE: new Texture.fromImage("img/tiles48/floor01.png"),
      Asset.DOOR_V_OPEN_TILE: new Texture.fromImage("img/tiles48/door_v_open.png"),
      Asset.DOOR_V_CLOSE_TILE: new Texture.fromImage("img/tiles48/door_v_closed.png"),
      Asset.DOOR_H_OPEN_TILE: new Texture.fromImage("img/tiles48/door_h_open.png"),
      Asset.DOOR_H_CLOSE_TILE: new Texture.fromImage("img/tiles48/door_h_closed.png"),
      Asset.WALL_NESW_TILE: new Texture.fromImage("img/tiles48/wall_0123.png"),
      Asset.WALL_ESW_TILE: new Texture.fromImage("img/tiles48/wall_123.png"),
      Asset.WALL_NSW_TILE: new Texture.fromImage("img/tiles48/wall_023.png"),
      Asset.WALL_NEW_TILE: new Texture.fromImage("img/tiles48/wall_013.png"),
      Asset.WALL_NES_TILE: new Texture.fromImage("img/tiles48/wall_012.png"),
      Asset.WALL_NE_TILE: new Texture.fromImage("img/tiles48/wall_01.png"),
      Asset.WALL_NS_TILE: new Texture.fromImage("img/tiles48/wall_v.png"),
      Asset.WALL_NW_TILE: new Texture.fromImage("img/tiles48/wall_03.png"),
      Asset.WALL_ES_TILE: new Texture.fromImage("img/tiles48/wall_12.png"),
      Asset.WALL_EW_TILE: new Texture.fromImage("img/tiles48/wall_h.png"),
      Asset.WALL_SW_TILE: new Texture.fromImage("img/tiles48/wall_23.png"),
      Asset.SWITCH_ON_TILE: new Texture.fromImage("img/tiles48/device.png")
    };
  }
}
