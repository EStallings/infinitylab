/* -*- dart -*- */

import 'AssetManager.dart';
class Tile {
  static const FLOOR = const Tile._(0);
  static const WALL = const Tile._(1);
  static const DOOR = const Tile._(2);
  static const ON_SWITCH = const Tile._(3);
  static const OFF_SWITCH = const Tile._(4);
  static get values => [FLOOR, WALL, DOOR, ON_SWITCH, OFF_SWITCH];

  final int value;
  const Tile._(this.value);

  Asset getAsset() {
    switch(value) {
    case 0: return Asset.FLOOR_TILE;
    case 1: return Asset.WALL_TILE;
    case 2: return Asset.DOOR_TILE;
    case 3: return Asset.SWITCH_ON_TILE;
    case 4: return Asset.SWITCH_OFF_TILE;

    }
  }
}
