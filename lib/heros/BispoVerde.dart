import 'dart:math';

import 'package:zero/heros/SuperHero.dart';

class BispoVerde extends SuperHero {
  BispoVerde()
      : super(
          heroId: 'bispoverde',
          name: "Bispo Verde",
          type: Type.attack,
          maxHp: 170,
          hp: 170,
          dmg: 20,
          spriteName: 'robos/bispo.png',
        );
  @override
  passive(SuperHero rival, bool turno) {
    if (turno && Random().nextBool()) {
      double dmgTotal = this.dmg + (this.dmg / 2);
      rival.hp = rival.hp - dmgTotal.toInt();
    }
  }
}
