/* -*- dart -*- */

import 'dart:html';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Grid.dart';
import 'Screen.dart';
class LabScreen extends Screen {
  double _rotRate = 0.0;
  DisplayObjectContainer _spriteBatch = new DisplayObjectContainer();
  Grid grid = new Grid();

  LabScreen() {
  }

  void onMouseUp(InteractionData e, ScreenStack stack) {
  }

  bool update(ScreenStack stack) {
    return true;
  }

  void render(ScreenStack stack, DisplayObjectContainer stage) {
    _spriteBatch.children.clear();
    grid.render(_spriteBatch);

    stage.children.clear();
    stage.children.add(_spriteBatch);
  }
}