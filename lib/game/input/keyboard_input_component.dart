import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import 'game_controls.dart';

/// Translates hardware keyboard state into [GameInputState].
///
/// Added directly to the game (not the world) so it keeps receiving events
/// regardless of what's happening in the level.
class KeyboardInputComponent extends Component with KeyboardHandler {
  KeyboardInputComponent(this.inputState);

  final GameInputState inputState;

  static final _leftKeys = {
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.keyA,
  };
  static final _rightKeys = {
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.keyD,
  };
  static final _jumpKeys = {
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyK,
  };
  static final _shootKeys = {
    LogicalKeyboardKey.keyJ,
    LogicalKeyboardKey.keyZ,
    LogicalKeyboardKey.keyX,
    LogicalKeyboardKey.keyF,
  };

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final left = keysPressed.any(_leftKeys.contains);
    final right = keysPressed.any(_rightKeys.contains);
    inputState.keyboardHorizontal = right ? 1.0 : (left ? -1.0 : 0.0);
    inputState.keyboardJumpHeld = keysPressed.any(_jumpKeys.contains);
    inputState.keyboardShootHeld = keysPressed.any(_shootKeys.contains);
    return true;
  }
}
