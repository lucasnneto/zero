import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:zero/util/functions.dart';

class Box extends GameDecoration with ObjectCollision {
  Box(Vector2 position, Size size)
      : super(
          position: position,
          width: getSizeByTileSize(size.width),
          height: getSizeByTileSize(size.height),
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: size,
          ),
        ],
      ),
    );
  }
}
