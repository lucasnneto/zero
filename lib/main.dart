import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zero/decoration/box.dart';
import 'package:zero/decoration/tree.dart';
import 'package:zero/heros/Heros.dart';
import 'package:zero/jogo.dart';
import 'package:zero/player/game_player.dart';
import 'package:zero/player/sprite_sheet.dart';
import 'person_select.dart';
import '/socket/SocketManager.dart';

double tileSize = 35;
String nick = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpriteSheetHero.load();
  await Heros.loadData();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }

  SocketManager.configure('http://zeroback.herokuapp.com');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonSelect(),
      // home: Jogo(),
    ),
  );
}
