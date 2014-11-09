/* -*- dart -*- */

import 'dart:html';
import 'AssetManager.dart';
import 'Screen.dart';
import 'LabScreen.dart';
import 'ScreenStack.dart';

class MainMenuScreen extends Screen {
  double _rotRate = 0.0;

  MainMenuScreen() {
    AssetManager.getSprite(Asset.TEST)
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
  }

  void onMouseUp(e, ScreenStack stack) {
    stack.push(new LabScreen());
  }

  bool update(ScreenStack stack) {
    _rotRate += 0.0001;
    AssetManager.getSprite(Asset.TEST).rotation += _rotRate;
    return true;
  }

  void render(ScreenStack stack, Stage stage) {
    stage.children.clear();
    stage.children.add(AssetManager.getSprite(Asset.TEST));
  }
}