import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import '../components/environment/parallax_layer_component.dart';
import '../components/environment/platform_component.dart';
import '../components/player/player_component.dart';
import '../iron_frontier_game.dart';
import '../utils/constants.dart';

/// Full Foundry Outpost level layout (future segments beyond stage 1 use
/// these markers once Factory Approach onward are built).
class FoundryOutpostLevel {
  static const double levelTotalWidth = 3200.0;
  static const double levelTotalHeight = 360.0;

  static const double seg1LandingZone = 0.0;
  static const double seg2FactoryApproach = 600.0;
  static const double seg3AssemblyCorridor = 1300.0;
  static const double seg4ReactorGate = 2000.0;
  static const double seg5SiegeArena = 2600.0;
}

/// Stage 1 playable slice: just the Landing Zone segment, flat ground,
/// two parallax background layers, and the player. Enemies, hazards, and the
/// remaining segments are later stages.
class LandingZoneWorld extends World with HasGameReference<IronFrontierGame> {
  static const double landingZoneWidth = 1200.0;
  static const double groundThickness = 32.0;

  late final PlayerComponent player;

  double get groundTopY => GameConstants.resolutionHeight - groundThickness;

  double get visibleWidth {
    if (game.camera.viewfinder.zoom > 0) {
      return game.size.x / game.camera.viewfinder.zoom;
    }
    return GameConstants.resolutionWidth;
  }

  void updateCameraBounds() {
    final curVisibleWidth = visibleWidth;
    final halfWidth = curVisibleWidth / 2;
    final boundWidth = landingZoneWidth - curVisibleWidth;

    if (boundWidth > 0) {
      game.camera.setBounds(
        Rectangle.fromLTWH(
          halfWidth,
          GameConstants.resolutionHeight / 2,
          boundWidth,
          0,
        ),
      );
    } else {
      game.camera.setBounds(
        Rectangle.fromLTWH(
          landingZoneWidth / 2,
          GameConstants.resolutionHeight / 2,
          0,
          0,
        ),
      );
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final skyImage = await game.images.load(
      'environments/foundry/sky_far.png',
    );
    add(
      ParallaxLayerComponent(
        sprite: Sprite(skyImage),
        scrollFactor: 0.08,
        position: Vector2.zero(),
        size: Vector2(landingZoneWidth + 600, GameConstants.resolutionHeight),
      ),
    );

    final midgroundImage = await game.images.load(
      'environments/foundry/background_landing_cutout.png',
    );
    add(
      ParallaxLayerComponent(
        sprite: Sprite(midgroundImage),
        scrollFactor: 0.35,
        position: Vector2.zero(),
        size: Vector2(landingZoneWidth + 600, GameConstants.resolutionHeight),
      ),
    );

    add(
      PlatformComponent(
        levelWidth: landingZoneWidth,
        position: Vector2(0, groundTopY),
      ),
    );

    player = PlayerComponent(
      groundPosition: Vector2(80, groundTopY),
      levelWidth: landingZoneWidth,
    );
    add(player);

    game.camera.follow(player, maxSpeed: 220, snap: true);
    updateCameraBounds();
  }
}
