/* -*- dart -*- */
import 'dart:html';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'MainMenuScreen.dart';
import 'Screen.dart';
import 'ScreenStack.dart';
import 'Util.dart';

class InfinityLab {

  Renderer _renderer;
  Stage _stage = new Stage(new Colour.fromHtml('#fff'));
  int _lastMS = new DateTime.now().millisecondsSinceEpoch;
  ScreenStack _screenStack = new ScreenStack();

  InfinityLab() {
    _init();
  }

  void run() {
    window.requestAnimationFrame(_doTick);
  }

  void _init() {
    AssetManager.init();
    _screenStack.push(new MainMenuScreen());
    _initListeners();
    _initRenderer();
  }

  void _initRenderer() {
    try {
      _renderer = new WebGLRenderer(width: Screen.WIDTH,
          height: Screen.HEIGHT, interactive: true);
    } catch (Exception) {
      print("WARNING: WebGL not supported. Using CanvasRenderer instead.\n");
      _renderer = new CanvasRenderer(width: Screen.WIDTH,
          height: Screen.HEIGHT, interactive: true);
    }
    document.body.append(_renderer.view);

    _stage.children.add(AssetManager.getSprite(Asset.TEST));
  }

  void _initListeners() {
    _stage.onMouseUp.listen((InteractionData e) {
      if (_screenStack.size() > 0) {
        _screenStack.peek().onMouseUp(e, _screenStack);
      }
    });
  }

  void _render() {
    _renderer.render(_stage);
  }

  void _clampFramerate() {
    int sleepMS = ((1000.0 / Screen.FPS) -
                   (new DateTime.now().millisecondsSinceEpoch - _lastMS)).floor();
    if (sleepMS > 0) {
      Util.sleep(sleepMS);
    }
   _lastMS = new DateTime.now().millisecondsSinceEpoch;
  }

  void _doTick(double num) {
    if (_screenStack.size() > 0) {
      if (!_screenStack.peek().update(_screenStack)) {
        _screenStack.pop();
      } else {
        _screenStack.peek().render(_stage);
        _render();
      }
      _clampFramerate();
      window.requestAnimationFrame(_doTick);
    }
  }
}