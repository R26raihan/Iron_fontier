import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../../iron_frontier_game.dart';
import '../../utils/constants.dart';
import '../environment/platform_component.dart';
import '../projectiles/projectile_component.dart';

enum PlayerAnimState { idle, run, jump }

/// The IRON Operative. Simple kinematic platformer physics (no engine body):
/// integrate gravity/velocity each frame, then let collision detection snap
/// the player back on top of whatever [PlatformComponent] it lands on.
class PlayerComponent extends PositionComponent
    with HasGameReference<IronFrontierGame>, CollisionCallbacks {
  PlayerComponent({required Vector2 groundPosition, required this.levelWidth})
    : super(
        position: groundPosition,
        size: Vector2.all(_displaySize),
        anchor: Anchor.bottomCenter,
      );

  /// On-screen bounding box. The source art has generous transparent padding
  /// around the character, so this is bigger than [PlayerConstants.canvasSize]
  /// to keep the visible figure close to its intended on-screen scale.
  static const double _displaySize = 64.0;

  final double levelWidth;

  int hp = PlayerConstants.maxHp;
  bool isFacingRight = true;
  bool isOnGround = false;
  final Vector2 velocity = Vector2.zero();
  double _shootCooldown = 0.0;

  late final SpriteAnimationGroupComponent<PlayerAnimState> _animationComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await game.images.load('characters/player/player_core.png');
    final sheet = SpriteSheet(
      image: image,
      srcSize: Vector2(image.width / 4, image.height / 4),
    );

    _animationComponent = SpriteAnimationGroupComponent<PlayerAnimState>(
      animations: {
        PlayerAnimState.idle: sheet.createAnimation(row: 0, stepTime: 0.16),
        PlayerAnimState.run: sheet.createAnimation(row: 1, stepTime: 0.09),
        PlayerAnimState.jump: sheet.createAnimation(
          row: 2,
          stepTime: 0.12,
          loop: false,
        ),
      },
      current: PlayerAnimState.idle,
      size: size.clone(),
      position: Vector2(0, 3.0),
      anchor: Anchor.topLeft,
    );
    await add(_animationComponent);

    add(
      RectangleHitbox(
        size: Vector2(
          PlayerConstants.hitboxWidth,
          PlayerConstants.hitboxHeight,
        ),
        position: Vector2(
          (size.x - PlayerConstants.hitboxWidth) / 2,
          size.y - PlayerConstants.hitboxHeight,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    final input = game.inputState;
    final horizontal = input.horizontalAxis;

    // isOnGround reflects last frame's collision result; capture it for the
    // jump check, then reset it — onCollision() re-affirms it later this same
    // tick if the player is still resting on a platform.
    final wasOnGround = isOnGround;
    isOnGround = false;

    velocity.y += PlayerConstants.gravity * dt;
    if (velocity.y > PlayerConstants.maxFallSpeed) {
      velocity.y = PlayerConstants.maxFallSpeed;
    }
    if (input.isJumpHeld && wasOnGround) {
      velocity.y = PlayerConstants.jumpForce;
    }

    position.x += horizontal * PlayerConstants.moveSpeed * dt;
    position.y += velocity.y * dt;

    final halfWidth = PlayerConstants.hitboxWidth / 2;
    position.x = position.x.clamp(halfWidth, levelWidth - halfWidth);

    _updateFacing(horizontal);
    // Uses last frame's grounded state since this tick's collision pass
    // (which would confirm landing) hasn't run yet.
    _updateAnimationState(horizontal, wasOnGround);

    // Handle weapon firing (auto-fire when button held)
    _shootCooldown -= dt;
    if (input.isShootHeld && _shootCooldown <= 0) {
      _shootCooldown = PlayerConstants.fireRate;
      _fireProjectile();
    }
  }

  void _fireProjectile() {
    final direction = isFacingRight ? 1.0 : -1.0;
    // Precisely aligned with the player's rifle barrel tip
    final spawnPos = Vector2(
      position.x + (direction * 18.0),
      position.y - 34,
    );

    game.world.add(
      ProjectileComponent(
        spawnPosition: spawnPos,
        directionX: direction,
        levelWidth: levelWidth,
      ),
    );
  }

  void _updateFacing(double horizontal) {
    if (horizontal > 0 && !isFacingRight) {
      isFacingRight = true;
      _animationComponent.flipHorizontallyAroundCenter();
    } else if (horizontal < 0 && isFacingRight) {
      isFacingRight = false;
      _animationComponent.flipHorizontallyAroundCenter();
    }
  }

  void _updateAnimationState(double horizontal, bool grounded) {
    final newState = !grounded
        ? PlayerAnimState.jump
        : (horizontal != 0 ? PlayerAnimState.run : PlayerAnimState.idle);
    if (_animationComponent.current != newState) {
      _animationComponent.current = newState;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlatformComponent && velocity.y >= 0) {
      position.y = other.position.y;
      velocity.y = 0;
      isOnGround = true;
    }
  }
}
