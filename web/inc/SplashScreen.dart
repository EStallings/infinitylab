/* -*- dart -*- */

import 'dart:html';
import 'AssetManager.dart';
import 'Screen.dart';
import 'MainMenuScreen.dart';
class SplashScreen extends Screen {

  Sprite _splashLogo = AssetManager.getSprite(Asset.SPLASHLOGO);

  SplashScreen() {
    _splashLogo
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    stack.push(new MainMenuScreen());
  }

  bool update(ScreenStack stack) {
    return true;
  }

  void render(Stage stage) {
    stage.children.clear();
    stage.children.add(_splashLogo);
  }
}