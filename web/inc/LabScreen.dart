/* -*- dart -*- */

import 'dart:html';
import 'AssetManager.dart';
import 'Screen.dart';
class LabScreen extends Screen {
  double _rotRate = 0.0;

  LabScreen() {
    AssetManager.getSprite(Asset.TEST2)
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    stack.pop();
  }

  bool update(ScreenStack stack) {
    _rotRate += 0.0001;
    AssetManager.getSprite(Asset.TEST2).rotation += _rotRate;
    return true;
  }

  void render(Stage stage) {
    stage.children.clear();
    stage.children.add(AssetManager.getSprite(Asset.TEST2));
  }
}