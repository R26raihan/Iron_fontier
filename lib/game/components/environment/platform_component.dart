import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../iron_frontier_game.dart';

enum PlatformType { solidGround, semiSolidPlatform, hazardPit }

/// A flat strip of solid ground, tiled with real `foundry_tileset.png` tiles
/// and backed by a single passive hitbox spanning its full width.
class PlatformComponent extends PositionComponent
    with HasGameReference<IronFrontierGame> {
  PlatformComponent({
    required this.levelWidth,
    required Vector2 position,
    this.type = PlatformType.solidGround,
  }) : super(
         position: position,
         size: Vector2(levelWidth, tileWorldSize),
         anchor: Anchor.topLeft,
       );

  static const double tileWorldSize = 32.0;

  final double levelWidth;
  final PlatformType type;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleHitbox(
        size: size,
        position: Vector2.zero(),
        collisionType: CollisionType.passive,
      ),
    );

    final image = await game.images.load(
      'environments/foundry/foundry_tileset.png',
    );
    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(image.width / 8, image.height / 4),
    );

    final floorMiddle = sheet.getSprite(0, 1);
    final floorLeftCap = sheet.getSprite(0, 0);
    final floorRightCap = sheet.getSprite(0, 3);

    final tileCount = (levelWidth / tileWorldSize).round();
    for (var i = 0; i < tileCount; i++) {
      final tile = i == 0
          ? floorLeftCap
          : (i == tileCount - 1 ? floorRightCap : floorMiddle);
      add(
        SpriteComponent(
          sprite: tile,
          position: Vector2(i * tileWorldSize, -3.0),
          size: Vector2.all(tileWorldSize),
        ),
      );
    }
  }
}
