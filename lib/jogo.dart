import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:zero/decoration/box.dart';
import 'package:zero/heros/Heros.dart';
import 'package:zero/heros/SuperHero.dart';
import 'package:zero/main.dart';
import 'package:zero/player/game_player.dart';
import 'package:zero/player/remote_player.dart';
import 'package:zero/player/slime.dart';
import 'package:zero/player/sprite_sheet.dart';
import 'package:zero/socket/SocketManager.dart';

import 'decoration/tree.dart';

class Jogo extends StatefulWidget {
  final String playerId;
  final String robo;
  final String side;
  final Map<dynamic, dynamic> playersOn;
  late SuperHero sp = Heros.heros[1];

  Jogo({
    Key? key,
    required this.side,
    required this.playerId,
    required this.robo,
    required this.playersOn,
  }) : super(key: key) {
    sp = Heros.heros.firstWhere((el) => el.heroId == this.robo);
  }
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> implements GameListener {
  GameController _controller = GameController();
  bool firstUpdate = false;
  @override
  void initState() {
    _controller.setListener(this);
    // _setupSocketControl();
    super.initState();
  }

  @override
  void dispose() {
    SocketManager().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      tileSize = max(constraints.maxHeight, constraints.maxWidth) / 22;
      return BonfireTiledWidget(
        // showCollisionArea: true,
        // collisionAreaColor: Colors.black,
        cameraConfig: CameraConfig(
          moveOnlyMapArea: true,
        ),
        joystick: Joystick(
          keyboardEnable: true,
          directional: JoystickDirectional(),
          // actions: [
          //   JoystickAction(
          //     actionId: 'basic',
          //     margin: EdgeInsets.only(bottom: 50, right: 50),
          //     size: 70,
          //   ),
          // ],
        ),
        player: GamePlayer(
          widget.playerId,
          widget.sp,
          Vector2(_side(widget.side)['x'] * tileSize,
              _side(widget.side)['y'] * tileSize),
        ),
        gameController: _controller,
        map: TiledWorldMap(
          'tile/map.json',
          forceTileSize: Size(tileSize, tileSize),
          objectsBuilder: {
            'tree': (p) => Tree(p.position),
            'box': (p) => Box(p.position, p.size),
            'wall': (p) => Box(p.position, p.size),
            // 'slime': (p) => Slime(p.position, SlimeColor.vermelho)
          },
        ),
      );
    });
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    _addPlayersOn();
  }

  SuperHero getSH(String id) {
    return Heros.heros.firstWhere((el) => el.heroId == id);
  }

  Map _side(side) {
    if (side == 'l')
      return {
        // 'x': 203.3174520272727 / tileSize,
        // 'y': 352.94099277272716 / tileSize
        'x': 0,
        'y': 0
      };
    else
      return {
        'x': 2,
        'y': 0,
        // 'x': 1011.506419786364 / tileSize,
        // 'y': 361.1844573818177 / tileSize
      };
  }

  void _addPlayersOn() {
    if (firstUpdate) return;
    firstUpdate = true;
    widget.playersOn.forEach((id, player) {
      if (player != null && id != widget.playerId) {
        _addRemotePlayer(player, id);
      }
    });
  }

  // void _setupSocketControl() {
  //   SocketManager().listen('message', (data) {
  //     if (data['action'] == 'PLAYER_JOIN' &&
  //         data['data']['id'] != widget.playerId) {
  //       _addRemotePlayer(data['data']);
  //     }
  //   });
  // }

  void _addRemotePlayer(Map<dynamic, dynamic> data, dynamic id) {
    Vector2 personPosition = Vector2(
      _side(data['side'])['x'] * tileSize,
      _side(data['side'])['y'] * tileSize,
    );
    print(id);
    var enemy = RemotePlayer(
      id,
      getSH(data['robo']),
      personPosition,
      SocketManager(),
    );
    if (data['life'] != null) {
      enemy.life = double.tryParse(data['life'].toString()) ?? 0.0;
    }
    _controller.addGameComponent(enemy);
    // _controller.addGameComponent(
    //   AnimatedObjectOnce(
    //     animation: SpriteSheetHero.smokeExplosion,
    //     position: Rect.fromLTRB(
    //       personPosition.x,
    //       personPosition.y,
    //       32,
    //       32,
    //     ).toVector2Rect(),
    //   ),
    // );
  }
}
