import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../../iron_frontier_game.dart';
import '../../utils/constants.dart';

enum ProjectileOwner {
  player,
  enemy,
}

/// High-speed plasma projectile fired by the player or enemies.
class ProjectileComponent extends PositionComponent
    with HasGameReference<IronFrontierGame>, CollisionCallbacks {
  ProjectileComponent({
    required Vector2 spawnPosition,
    required this.directionX,
    this.owner = ProjectileOwner.player,
    this.speed = PlayerConstants.bulletSpeed,
    this.damage = 1,
    this.levelWidth = 3200.0,
  }) : super(
         position: spawnPosition,
         size: Vector2(16.0, 6.0),
         anchor: Anchor.center,
       );

  final ProjectileOwner owner;
  final double speed;
  final double directionX;
  final int damage;
  final double levelWidth;

  final Paint _outerGlowPaint = Paint()
    ..color = GameConstants.colorCyberCyan.withAlpha(180)
    ..style = PaintingStyle.fill;

  final Paint _corePaint = Paint()
    ..color = GameConstants.colorPureHighlight
    ..style = PaintingStyle.fill;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (owner == ProjectileOwner.enemy) {
      _outerGlowPaint.color = GameConstants.colorHazardOrange.withAlpha(180);
    }

    add(
      RectangleHitbox(
        size: size,
        collisionType: CollisionType.active,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += directionX * speed * dt;

    // Remove when out of level bounds
    if (position.x < -50 || position.x > levelWidth + 50) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Outer plasma glow
    final outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(3),
    );
    canvas.drawRRect(outerRect, _outerGlowPaint);

    // Inner bright energy core
    final coreRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 1.5, size.x - 4, size.y - 3),
      const Radius.circular(1.5),
    );
    canvas.drawRRect(coreRect, _corePaint);
  }
}
