/* -*- dart -*- */

import 'dart:math';
class Direction {
  static const NORTH = const Direction._(0);
  static const EAST = const Direction._(1);
  static const SOUTH = const Direction._(2);
  static const WEST = const Direction._(3);
  static get values => [NORTH, EAST, SOUTH, WEST];

  final int value;
  const Direction._(this.value);

  Point<int> offset(int x, int y) {
    switch(value) {
      case 0: return new Point<int>(x, y - 1);
      case 1: return new Point<int>(x + 1, y);
      case 2: return new Point<int>(x, y + 1);
      case 3: return new Point<int>(x - 1, y);
    }
  }
}