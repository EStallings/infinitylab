/* -*- dart -*- */

import 'dart:html';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Screen.dart';
class LabScreen extends Screen {
  double _rotRate = 0.0;
  DisplayObjectContainer _spriteBatch = new DisplayObjectContainer();

  LabScreen() {
    AssetManager.getSprite(Asset.TEST2)
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);

    _spriteBatch.children.add(AssetManager.getSprite(Asset.TEST2));
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
    stack.pop();
  }

  bool update(ScreenStack stack) {
    _rotRate += 0.0001;
    AssetManager.getSprite(Asset.TEST2).rotation += _rotRate;
    return true;
  }

  void render(ScreenStack stack, Stage stage) {
    stage.children.clear();
    stage.children.add(_spriteBatch);
  }
}