import 'dart:ui';

import 'package:bonfire/bonfire.dart';

class SpriteSheetHero {
  static SpriteSheet? slime;

  static load() async {
    slime = await _create('slime.png', rows: 20, columns: 10);
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
