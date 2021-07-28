// import 'dart:math';

// import 'package:bonfire/bonfire.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:zero/interface/player_interface.dart';
// import 'package:zero/main.dart';
// import 'package:zero/player/game_player.dart';
// import 'package:zero/player/remote_player.dart';
// import 'package:zero/player/sprite_sheet_hero.dart';
// import 'package:zero/socket/SocketManager.dart';

// import 'decoration/tree.dart';

// class Game extends StatefulWidget {
//   final int playerId;
//   final String robo;
//   final Vector2 position;
//   final List<dynamic> playersOn;

//   const Game(
//       {Key? key,
//       required this.position,
//       required this.playerId,
//       required this.robo,
//       required this.playersOn})
//       : super(key: key);
//   @override
//   _GameState createState() => _GameState();
// }

// class _GameState extends State<Game> implements GameListener {
//   GameController _controller = GameController();
//   bool firstUpdate = false;
//   @override
//   void initState() {
//     _controller.setListener(this);
//     _setupSocketControl();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SocketManager().close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       tileSize = max(constraints.maxHeight, constraints.maxWidth) / 30;
//       return BonfireTiledWidget(
//         joystick: Joystick(
//           keyboardEnable: true,
//           directional: JoystickDirectional(
//             spriteKnobDirectional: Sprite.load('joystick_knob.png'),
//             spriteBackgroundDirectional: Sprite.load('joystick_background.png'),
//             size: 100,
//           ),
//           actions: [
//             JoystickAction(
//               actionId: 0,
//               sprite: Sprite.load('joystick_atack.png'),
//               spritePressed: Sprite.load('joystick_atack_selected.png'),
//               size: 80,
//               margin: EdgeInsets.only(bottom: 50, right: 50),
//             ),
//           ],
//         ),
//         player: GamePlayer(
//           widget.playerId,
//           widget.nick,
//           Vector2(widget.position.x * tileSize, widget.position.y * tileSize),
//           _getSprite(widget.idCharacter),
//         ),
//         interface: PlayerInterface(),
//         map: TiledWorldMap(
//           'tile/map.json',
//           forceTileSize: Size(tileSize, tileSize),
//           objectsBuilder: {
//             'tree': (p) => Tree(p.position),
//           },
//         ),
//         constructionModeColor: Colors.black,
//         collisionAreaColor: Colors.purple.withOpacity(0.4),
//         gameController: _controller,
//         cameraConfig: CameraConfig(
//           moveOnlyMapArea: true,
//         ),
//       );
//     });
//   }

//   @override
//   void changeCountLiveEnemies(int count) {}

//   @override
//   void updateGame() {
//     _addPlayersOn();
//   }

//   void _addPlayersOn() {
//     if (firstUpdate) return;
//     firstUpdate = true;
//     //FIX NÃO É MAIS UM ARRAY AGR É OBJ
//     widget.playersOn.forEach((player) {
//       if (player != null && player['id'] != widget.playerId) {
//         _addRemotePlayer(player);
//       }
//     });
//   }

//   void _setupSocketControl() {
//     SocketManager().listen('message', (data) {
//       if (data['action'] == 'PLAYER_JOIN' &&
//           data['data']['id'] != widget.playerId) {
//         _addRemotePlayer(data['data']);
//       }
//     });
//   }

//   void _addRemotePlayer(Map data) {
//     //FIX ALL
//     Vector2 personPosition = Vector2(
//       double.parse(data['position']['x'].toString()) * tileSize,
//       double.parse(data['position']['y'].toString()) * tileSize,
//     );

//     var enemy = RemotePlayer(
//       data['id'],
//       data['nick'],
//       personPosition,
//       _getSprite(data['skin'] ?? 0),
//       SocketManager(),
//     );
//     if (data['life'] != null) {
//       enemy.life = double.parse(data['life'].toString()) ?? 0.0;
//     }
//     _controller.addGameComponent(enemy);
//     _controller.addGameComponent(
//       AnimatedObjectOnce(
//         animation: SpriteSheetHero.smokeExplosion,
//         position: Rect.fromLTRB(
//           personPosition.x,
//           personPosition.y,
//           32,
//           32,
//         ).toVector2Rect(),
//       ),
//     );
//   }
// }
