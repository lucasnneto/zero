import 'package:zero/heros/BispoVerde.dart';
import 'package:zero/heros/SuperHero.dart';
import 'package:zero/heros/TorreVermelha.dart';

class Heros {
  static List<SuperHero> heros = [];

  static loadData() async {
    heros.add(
      TorreVermelha(),
    );
    heros.add(
      BispoVerde(),
    );
    for (SuperHero h in heros) {
      await h.loadSprite();
    }
  }
}
