/* -*- dart -*- */
import 'dart:html';
import 'lib/pixi.dart';

class Screen {
  /* Ahhhh these aren't constant so don't modify them. */
  static const int HEIGHT = 480;
  static const int WIDTH = 640;
}

class AssetManager {
  static Renderer renderer;
  static Stage stage = new Stage(new Colour.fromHtml('#fff'));
  static Sprite sprite;
  static double rotRate = 0.0;

  void _init() {
    sprite = new Sprite.fromImage("img/test.png");
    try {
      renderer = new WebGLRenderer(width: Screen.WIDTH,
                                   height: Screen.HEIGHT);
    } catch (Exception) {
      print("WARNING: WebGL not supported. Using CanvasRenderer instead.\n");
      renderer = new CanvasRenderer(width: Screen.WIDTH,
                                    height: Screen.HEIGHT);
    }
  }

  AssetManager() {
    _init();
    document.body.append(renderer.view);

    sprite.anchor = new Point(0.5, 0.5);
    sprite.position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);

    stage.children.add(sprite);
  }

  void run() {
    window.requestAnimationFrame(_animate);
  }

  void _animate(double num) {
    window.requestAnimationFrame(_animate);
    sprite.rotation += rotRate;
    rotRate += 0.0001;
    renderer.render(stage);
  }
}

void main() {
  new AssetManager().run();
}
