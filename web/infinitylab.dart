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

  void init() {
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
    init();
    document.body.append(renderer.view);

    sprite.anchor = new Point(0.5, 0.5);
    sprite.position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);

    stage.children.add(sprite);
    window.requestAnimationFrame(this.animate);
  }

  void animate(double num) {
    window.requestAnimationFrame(this.animate);
    sprite.rotation += 0.1;
    renderer.render(stage);
  }
}

void main() {
  new AssetManager();
}
