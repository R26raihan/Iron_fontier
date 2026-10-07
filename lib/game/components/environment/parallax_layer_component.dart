import 'package:flame/components.dart';

import '../../iron_frontier_game.dart';
import '../../utils/constants.dart';

/// A background layer that scrolls slower than the foreground, proportional
/// to [scrollFactor] (0 = fixed to camera / stays put, 1 = moves 1:1 with the
/// world like normal terrain).
///
/// Counteracts part of the camera's own horizontal movement each frame to
/// fake depth without needing a tiling parallax system for this short stage.
class ParallaxLayerComponent extends SpriteComponent
    with HasGameReference<IronFrontierGame> {
  ParallaxLayerComponent({
    required Sprite sprite,
    required this.scrollFactor,
    required Vector2 position,
    required super.size,
  }) : baseWorldX = position.x,
       super(sprite: sprite, position: position, anchor: Anchor.topLeft);

  final double scrollFactor;
  final double baseWorldX;

  @override
  void update(double dt) {
    super.update(dt);
    final visibleWidth = game.camera.viewfinder.zoom > 0
        ? (game.size.x / game.camera.viewfinder.zoom)
        : GameConstants.resolutionWidth;
    final cameraLeft = game.camera.viewfinder.position.x - (visibleWidth / 2);
    position.x = baseWorldX + cameraLeft * (1 - scrollFactor);
  }
}
