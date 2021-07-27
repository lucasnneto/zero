import 'dart:ui';

import 'package:bonfire/bonfire.dart';

class SpriteSheetHero {
  static SpriteSheet? hero1;
  static SpriteSheet? hero2;

  static load() async {
    hero1 = await _create('robos/torre.png');
    hero2 = await _create('robos/bispo.png');
  }

  static loadSprint(name) async {
    return await _create(name);
  }

  static Future<SpriteSheet> _create(String path,
      {int columns = 13, int rows = 21}) async {
    Image image = await Flame.images.load(path);
    return SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: columns,
      rows: rows,
    );
  }
}
