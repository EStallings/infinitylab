/* -*- dart -*- */
import 'Screen.dart';

class ScreenStack {
  List<Screen> _screens = new List<Screen>();

  void push(Screen screen) {
    _screens.add(screen);
  }

  int size() {
    return _screens.length;
  }

  bool canPeek() {
    return size() > 0;
  }

  Screen pop() {
    return _screens.removeLast();
  }

  Screen peek() {
    return _screens.last;
  }
}