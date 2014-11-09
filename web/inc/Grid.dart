/* -*- dart -*- */

import 'dart:math';
import '../lib/pixi.dart';
import 'AssetManager.dart';
import 'Direction.dart';
import 'Tile.dart';
class Grid {

final String mapString =
  "-----------------------------------"
  "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-"
  "-xwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwffpffdffpffdffpffdffpffdffpffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwffpffdffpffdffpffdffpffdffpffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwffpffdffpffdffpffdffpffdffpffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwffpffdffpffdffpffdffpffdffpffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwwwdwwwwwdwwwwwdwwwwwdwwwwwdwwwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwffpffdffpffdffpffdffpffdffpffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwfffffwfffffwfffffwfffffwfffffwx-"
  "-xwwwwwwwwwwwwwwwdwwwwwwwwwwwwwwwx-"
  "-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-"
  "-----------------------------------";

  final int width  = 35;
  final int height = 34;

  List<List<Tile>> _mapData;

  Grid() {
    _initMapData();
  }

  Tile getMapStringTile(int x, int y) {
    switch(mapString[y * width + x]) {
      case '-':
      case 'f':
      case 'x':
        return Tile.FLOOR;
      case 'w':
        return Tile.WALL;
      case 'p':
        return Tile.ON_SWITCH;
      case 'd':
        return Tile.DOOR;
    }
  }

  void _initMapData() {
    _mapData = new List<List<Tile>>();
    for (int x = 0; x < width; x++) {
      _mapData.add(new List<Tile>());
      for(int y = 0; y < height; y++) {
        _mapData[x].add(getMapStringTile(x, y));
      }
    }
  }

  bool isLiveSiteInt(int x, int y) {
    return x >= 0 && y >= 0 && x < width && y < height;
  }

  bool isLiveSitePoint(Point<int> pt) {
    return isLiveSiteInt(pt.x, pt.y);
  }

  Asset findWallAsset(int x, int y) {
    int walls = 0;
    Point<int> pt;
    for (Direction d in Direction.values) {
      walls *= 2;
      pt = d.offset(x, y);
      if (!isLiveSitePoint(pt) ||
          getTile(pt.x, pt.y) != Tile.FLOOR) {
        walls += 1;
      }
    }

    switch(walls) {
      case 15: return Asset.WALL_NESW_TILE;
      case 7:  return Asset.WALL_ESW_TILE;
      case 11: return Asset.WALL_NSW_TILE;
      case 13: return Asset.WALL_NEW_TILE;
      case 14: return Asset.WALL_NES_TILE;

      case 3:  return Asset.WALL_SW_TILE;
      case 6:  return Asset.WALL_ES_TILE;
      case 5:  return Asset.WALL_EW_TILE;
      case 12: return Asset.WALL_NE_TILE;
      case 9:  return Asset.WALL_NW_TILE;
    }
    return Asset.WALL_NS_TILE;
  }

  Asset findDoorAsset(int x, int y) {
    if (isLiveSiteInt(x, y - 1)) {
      if (getTile(x, y - 1) == Tile.WALL) {
        return Asset.DOOR_V_CLOSE_TILE;
      }
    }
    return Asset.DOOR_H_CLOSE_TILE;
  }

  Sprite getMapSprite(int x, int y) {
    Asset a;
    switch(getTile(x, y)) {
      case Tile.WALL:
        a = findWallAsset(x, y);
        break;
      case Tile.DOOR:
        a = findDoorAsset(x, y);
        break;
      case Tile.FLOOR:
      case Tile.ON_SWITCH:
      case Tile.OFF_SWITCH:
        a = getTile(x, y).getAsset();
    }
    Texture t = AssetManager.getTexture(a);
    if (t == null) {
      throw "Grid.getMapSprite: Texture is null!";
    }
    Sprite s = new Sprite(t)
      ..position = new Point(x * t.width, y * t.height);
    if (s == null) {
      throw "Grid.getMapSprite: Null sprite!";
    }
    return s;
  }

  Tile getTile(int x, int y) {
    return _mapData[x][y];
  }

  void setTile(int x, int y, Tile t) {
    _mapData[x][y] = t;
  }

  void render(DisplayObjectContainer g) {
    for(int x = 0; x < width; x++) {
      for(int y = 0; y < height; y++) {
        g.children.add(getMapSprite(x, y));
      }
    }
  }
}