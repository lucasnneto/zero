import 'dart:async' as async;
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero/heros/SuperHero.dart';
import 'package:zero/main.dart';
import 'package:zero/player/sprite_sheet.dart';
import 'package:zero/socket/SocketManager.dart';

enum SlimeColor { verde, azul, vermelho, amarelo }

class Slime extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  final Vector2 initPosition;
  final SlimeColor cor;
  double attack = 25;

  Slime(this.initPosition, this.cor)
      : super(
          animation: SimpleDirectionAnimation(
            idleUp: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 2 + (5 * cor.index), stepTime: 0.17, to: 10)),
            idleDown: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 2 + (5 * cor.index), stepTime: 0.17, to: 10)),
            idleLeft: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 2 + (5 * cor.index), stepTime: 0.17, to: 10)),
            idleRight: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 2 + (5 * cor.index), stepTime: 0.17, to: 10)),
            runUp: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 1 + (5 * cor.index), stepTime: 0.17, to: 10)),
            runDown: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 1 + (5 * cor.index), stepTime: 0.17, to: 10)),
            runLeft: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 1 + (5 * cor.index), stepTime: 0.17, to: 10)),
            runRight: Future.value(SpriteSheetHero.slime!.createAnimation(
                row: 1 + (5 * cor.index), stepTime: 0.17, to: 10)),
          ),
          width: tileSize * 2,
          height: tileSize * 2,
          position: initPosition,
          life: 100,
          speed: tileSize * 1.7,
        ) {
    setupCollision(CollisionConfig(collisions: [
      CollisionArea.rectangle(
        size: Size((tileSize * 0.8), (tileSize * 0.8)),
        align: Vector2((tileSize * 0.5), tileSize * 1.3),
      ),
    ]));
  }

  @override
  void update(double dt) {
    runRandomMovement(
      dt,
      speed: speed / 2,
      maxDistance: (tileSize * 3).toInt(),
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
