import 'dart:math';

import 'package:zero/heros/SuperHero.dart';

class TorreVermelha extends SuperHero {
  bool _uso = false;
  TorreVermelha()
      : super(
          heroId: 'torrevermelha',
          name: "Torre Vermelha",
          type: Type.defense,
          maxHp: 320,
          hp: 320,
          dmg: 10,
          spriteName: "robos/torre.png",
        );
  @override
  passive(SuperHero rival, bool turno) {
    if (Random().nextDouble() <= 0.1) {
      double finalHp = this.hp + this.maxHp * 0.05;
      this.hp = finalHp.toInt();
    }

    if (!_uso) {
      _uso = true;
      if (this.maxHp <= (this.hp * 0.3)) {
        double finalHp = this.hp + 60;
        this.hp = finalHp.toInt();
      }
    }
  }
}
