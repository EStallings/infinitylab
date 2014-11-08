/* -*- dart -*- */
import 'dart:html';
import '../lib/pixi.dart';
import 'Screen.dart';

class Asset {
  static const TEST = const Asset._(0);
  static const TEST2 = const Asset._(1);
  static get values => [TEST, TEST2];

  final int value;
  const Asset._(this.value);
}

class FontAsset {
  static const DEFAULT = const FontAsset._(0);
  static get values => [DEFAULT];

  final int value;
  const FontAsset._(this.value);
}

class AssetManager {
  static Map _sprites;
  static bool _initialized = false;

  _AssetManager() {
    throw "AssetManager(): AssetManager cannot be instantiated!\n";
  }

  static Sprite getSprite(Asset a) {
    if(!_initialized) {
      throw "AssetManager.getSprite(): AssetManager not initialized!\n";
    }
    return _sprites[a];
  }

  static void init() {
    if(_initialized) {
      throw "AssetManager.init(): AssetManager already initialized!\n";
    }
    _initSprites();
    _initialized = true;
  }

  static void _initSprites() {
    _sprites = {
      Asset.TEST: new Sprite.fromImage("img/test.png"),
      Asset.TEST2: new Sprite.fromImage("img/test2.png")
    };
  }
}
