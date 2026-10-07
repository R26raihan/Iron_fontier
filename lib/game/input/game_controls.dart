/// Shared input state consumed by [PlayerComponent].
///
/// Keyboard and touch are independent sources so one can't stomp the other;
/// keyboard wins when both are active since it implies a desktop tester.
class GameInputState {
  double keyboardHorizontal = 0.0;
  double touchHorizontal = 0.0;
  bool keyboardJumpHeld = false;
  bool touchJumpHeld = false;
  bool keyboardShootHeld = false;
  bool touchShootHeld = false;

  double get horizontalAxis =>
      keyboardHorizontal != 0.0 ? keyboardHorizontal : touchHorizontal;

  bool get isJumpHeld => keyboardJumpHeld || touchJumpHeld;
  bool get isShootHeld => keyboardShootHeld || touchShootHeld;

  void reset() {
    keyboardHorizontal = 0.0;
    touchHorizontal = 0.0;
    keyboardJumpHeld = false;
    touchJumpHeld = false;
    keyboardShootHeld = false;
    touchShootHeld = false;
  }
}
