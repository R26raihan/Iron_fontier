import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'input/game_controls.dart';
import 'input/keyboard_input_component.dart';
import 'levels/foundry_outpost_level.dart';
import 'managers/game_state_manager.dart';
import 'utils/constants.dart';

/// Main IronFrontier game controller — Stage 1: Landing Zone slice.
class IronFrontierGame extends FlameGame<LandingZoneWorld>
    with HasKeyboardHandlerComponents<LandingZoneWorld>, HasCollisionDetection {
  IronFrontierGame()
    : super(
        world: LandingZoneWorld(),
        camera: CameraComponent(),
      );

  final GameStateManager stateManager = GameStateManager();
  final GameInputState inputState = GameInputState();

  @override
  Future<void> onLoad() async {
    images.prefix = 'assets/';
    await super.onLoad();
    stateManager.reset();
    await add(KeyboardInputComponent(inputState));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (size.y > 0) {
      camera.viewfinder.zoom = size.y / GameConstants.resolutionHeight;
      world.updateCameraBounds();
    }
  }
}
