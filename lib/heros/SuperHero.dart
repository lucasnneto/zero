import 'package:bonfire/bonfire.dart';
import 'package:zero/player/sprite_sheet_hero.dart';

class SuperHero {
  final String heroId;
  final String name;
  final Type type;
  final int maxHp;
  int hp;
  final int dmg;
  final String spriteName;
  SpriteSheet? sprite;
  SuperHero({
    required this.heroId,
    required this.name,
    required this.type,
    required this.maxHp,
    required this.hp,
    required this.dmg,
    required this.spriteName,
  });
  Future<void> loadSprite() async {
    this.sprite = await SpriteSheetHero.loadSprint(spriteName);
    return Future.value();
  }

  dynamic passive(SuperHero rival, bool turno) {
    return null;
  }

  String typeString() {
    if (this.type == Type.defense) return "Defesa";
    if (this.type == Type.attack) return "Ataque";
    if (this.type == Type.special) return "Especial";
    return "";
  }
}

enum Type { defense, attack, special }
