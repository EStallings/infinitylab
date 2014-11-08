/* -*- dart -*- */

import 'dart:html';
import 'dart:math';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Screen.dart';
import 'LabScreen.dart';
class SplashScreen extends Screen {

  Sprite _splashLogo = AssetManager.getSprite(Asset.SPLASHLOGO);
  DisplayObjectContainer _spriteBatch = new DisplayObjectContainer();
  BitmapText _text = null;

  SplashScreen() {
    _splashLogo
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    //stack.push(new LabScreen());
    _spriteBatch.children.clear();
    if (_text == null) {
      _text = AssetManager.renderStr("POOP", FontAsset.AVENIR);
      if (_text != null) {
        _text.position = new Point(100, 100);
        _spriteBatch.children.add(_text);
      }
    } else {
      _text = null;
    }
  }

  bool update(ScreenStack stack) {
    return true;
  }

  void render(Stage stage) {
    stage.children.clear();
    stage.children.add(_spriteBatch);
  }
}