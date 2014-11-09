/* -*- dart -*- */
library InfScreen;

import 'dart:html';
import '../lib/pixi.dart';
import 'ScreenStack.dart';
abstract class Screen {
  static final int WIDTH = 1680;
  static final int HEIGHT = 1680;
  static const double FPS = 30.0;

  /**
   * Called when a MouseUp event happens at any location on the web page.
   */
  /* abstract */ void onMouseUp(e, ScreenStack stack);

  /**
   * Called when this Screen should update itself, once per frame.
   *
   * @returns false if this Screen should be disposed of, else false.
   */
  /* abstract */ bool update(ScreenStack stack);

  /**
   * Called when this Screen should render itself, once per frame.
   */
  /* abstract */ void render(ScreenStack stack, DisplayObjectContainer g);
}