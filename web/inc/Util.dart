/* -*- dart -*- */
library Util;
import 'dart:async';
class Util {
  _Util() {
    throw "Util cannot be instantiated!\n";
  }

  static void sleep(int ms) {
    new Future.delayed(new Duration(milliseconds: ms), () => true);
  }
}
