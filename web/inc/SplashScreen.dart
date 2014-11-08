/* -*- dart -*- */

import 'dart:html';
import 'dart:math';
import 'AssetManager.dart';
import 'Screen.dart';
import 'MainMenuScreen.dart';
class SplashScreen extends Screen {

  Sprite _splashLogo = AssetManager.getSprite(Asset.SPLASHLOGO);
  BitmapText _text = null;

  SplashScreen() {
    _splashLogo
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    if (_text == null) {
      _text = AssetManager.renderStr("POOP", FontAsset.COMICBULLSHIT)
        ..position = new Point(200, 200);
    } else {
      _text = null;
    }
  }

  bool update(ScreenStack stack) {
    if (_text != null) {
      _text.rotation += 0.2;
      _text.position = new Point(200 + 100 * sin(_text.rotation),
                                 200 + 100 * cos(_text.rotation));
    }
    return true;
  }

  void render(Stage stage) {
    stage.children.clear();
    stage.children.add(_splashLogo);
    if (_text != null) {
      stage.children.add(_text);
    }
  }
}