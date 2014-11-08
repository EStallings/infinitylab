/* -*- dart -*- */
library Screen;

import '../lib/pixi.dart';
import 'ScreenStack.dart';
abstract class Screen {
  static const int HEIGHT = 480;
  static const int WIDTH = 800;
  static const double FPS = 30.0;

  /**
   * Called when a MouseUp event happens at any location on the web page.
   */
  /* abstract */ void onMouseUp(InteractionData e);

  /**
   * Called when this Screen should update itself, once per frame.
   *
   * @returns false if this Screen should be disposed of, else false.
   */
  /* abstract */ bool update(ScreenStack stack);

  /**
   * Called when this Screen should render itself, once per frame.
   */
  /* abstract */ void render(Stage stage);
}