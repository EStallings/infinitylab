/* -*- dart -*- */
library Screen;

import '../lib/pixi.dart';
import 'ScreenStack.dart';
abstract class Screen {
  static const int HEIGHT = 480;
  static const int WIDTH = 640;
  static const double FPS = 30.0;

  /* abstract */ void onMouseUp(InteractionData e);

  /* abstract */ bool update(ScreenStack stack);

  /* abstract */ void render(Stage stage);
}