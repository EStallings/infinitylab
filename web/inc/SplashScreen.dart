/* -*- dart -*- */

import 'dart:html';
import 'dart:math';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Screen.dart';
import 'LabScreen.dart';
class SplashScreen extends Screen {

  Sprite _splashLogo = AssetManager.getNewSprite(new Point(100, 100),
      Asset.SPLASHLOGO);
  DisplayObjectContainer _spriteBatch = new DisplayObjectContainer();
  BitmapText _text = null;

  SplashScreen() {
    _splashLogo
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
    _spriteBatch.children.add(_splashLogo);
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    stack.push(new LabScreen());
  }

  bool update(ScreenStack stack) {
    return true;
  }

  void render(ScreenStack stack, DisplayObjectContainer g) {
    g.children.clear();
    g.children.add(_spriteBatch);
  }
}