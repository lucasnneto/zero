import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:zero/heros/SuperHero.dart';
import 'package:zero/main.dart';
import 'package:zero/player/server_player_control.dart';
import 'package:zero/player/sprite_sheet.dart';
import 'package:zero/socket/SocketManager.dart';
import 'package:zero/util/extensions.dart';

class RemotePlayer extends SimpleEnemy
    with ServerRemotePlayerControl, ObjectCollision {
  final String id;
  final SuperHero hero;
  TextPaint? _textConfig;

  RemotePlayer(
      this.id, this.hero, Vector2 initPosition, SocketManager socketManager)
      : super(
          animation: SimpleDirectionAnimation(
            idleUp: Future.value(
                hero.sprite!.createAnimation(row: 8, stepTime: 0.17, to: 1)),
            idleDown: Future.value(
                hero.sprite!.createAnimation(row: 10, stepTime: 0.17, to: 1)),
            idleLeft: Future.value(
                hero.sprite!.createAnimation(row: 9, stepTime: 0.17, to: 1)),
            idleRight: Future.value(
                hero.sprite!.createAnimation(row: 11, stepTime: 0.17, to: 1)),
            runUp: Future.value(
                hero.sprite!.createAnimation(row: 8, stepTime: 0.1, to: 9)),
            runDown: Future.value(
                hero.sprite!.createAnimation(row: 10, stepTime: 0.1, to: 9)),
            runLeft: Future.value(
                hero.sprite!.createAnimation(row: 9, stepTime: 0.1, to: 9)),
            runRight: Future.value(
                hero.sprite!.createAnimation(row: 11, stepTime: 0.1, to: 9)),
          ),
          position: initPosition,
          width: tileSize * 1.5,
          height: tileSize * 1.5,
          life: 100, // TODO MUDAR AQUI
          speed: tileSize * 3,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Size((tileSize * 0.5), (tileSize * 0.5)),
            align: Vector2((tileSize * 0.9) / 2, tileSize),
          ),
        ],
      ),
    );
    _textConfig = TextPaint(
      config: TextPaintConfig(
        fontSize: tileSize / 4,
        color: Colors.white,
      ),
    );
    setupServerPlayerControl(socketManager, id);
  }

  @override
  void render(Canvas canvas) {
    if (this.isVisibleInCamera()) {
      _renderNickName(canvas);
      // this.drawDefaultLifeBar(
      //   canvas,
      //   height: 4,
      //   borderWidth: 2,
      //   borderRadius: BorderRadius.circular(2),
      // );
    }
    super.render(canvas);
  }

  @override
  void die() {
    // gameRef.add(
    //   AnimatedObjectOnce(
    //     animation: SpriteSheetHero.smokeExplosion,
    //     position: position,
    //   ),
    // );
    // gameRef.addGameComponent(
    //   GameDecoration.withSprite(
    //     Sprite.load('crypt.png'),
    //     position: Vector2(
    //       position.left,
    //       position.top,
    //     ),
    //     height: 30,
    //     width: 30,
    //   ),
    // );
    // remove();
    super.die();
  }

  void _renderNickName(Canvas canvas) {
    _textConfig!.render(
      canvas,
      hero.name,
      Vector2(
        position.left + ((width - (hero.name.length * (width / 13))) / 2),
        position.top - 20,
      ),
    );
  }

  @override
  void serverAttack(String direction) {
    // var anim = SpriteSheetHero.attackAxe;
    // this.simpleAttackRange(
    //   id: id,
    //   animationRight: anim,
    //   animationLeft: anim,
    //   animationUp: anim,
    //   animationDown: anim,
    //   interval: 0,
    //   direction: direction.getDirectionEnum(),
    //   animationDestroy: SpriteSheetHero.smokeExplosion,
    //   width: tileSize * 0.9,
    //   height: tileSize * 0.9,
    //   speed: speed * 1.5,
    //   damage: 15,
    //   collision: CollisionConfig(
    //     collisions: [
    //       CollisionArea.rectangle(size: Size(tileSize * 0.9, tileSize * 0.9))
    //     ],
    //   ),
    // );
  }

  @override
  void receiveDamage(double damage, from) {}
}
