/* -*- dart -*- */
import 'dart:html';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Screen.dart';
import 'Util.dart';

class InfinityLab {

  Renderer _renderer;
  Stage _stage = new Stage(new Colour.fromHtml('#fff'));
  double _rotRate = 0.0;
  int _lastMS = new DateTime.now().millisecondsSinceEpoch;

  InfinityLab() {
    _init();
  }

  void run() {
    window.requestAnimationFrame(_doTick);
  }

  void _init() {
    AssetManager.init();
    _initRenderer();
  }

  void _initRenderer() {
    try {
      _renderer = new WebGLRenderer(width: Screen.WIDTH,
          height: Screen.HEIGHT);
    } catch (Exception) {
      print("WARNING: WebGL not supported. Using CanvasRenderer instead.\n");
      _renderer = new CanvasRenderer(width: Screen.WIDTH,
          height: Screen.HEIGHT);
    }
    document.body.append(_renderer.view);

    AssetManager.getSprite(Asset.TEST)
      ..anchor = new Point(0.5, 0.5)
      ..position = new Point(Screen.WIDTH / 2, Screen.HEIGHT / 2);

    _stage.children.add(AssetManager.getSprite(Asset.TEST));
  }

  void _update() {
    _rotRate += 0.0001;
    AssetManager.getSprite(Asset.TEST).rotation += _rotRate;
  }

  void _render() {
    _renderer.render(_stage);
  }

  void _clampFramerate() {
    int sleepMS = ((1000.0 / Screen.FPS) -
                   (new DateTime.now().millisecondsSinceEpoch - _lastMS));
    if (sleepMS > 0) {
      Util.sleep(sleepMS);
    }
   _lastMS = new DateTime.now().millisecondsSinceEpoch;
  }

  void _doTick(double num) {
    _update();
    _render();
    _clampFramerate();
    window.requestAnimationFrame(_doTick);
  }
}