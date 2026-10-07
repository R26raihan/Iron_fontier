enum PatrolBotState {
  idle,
  walk,
  shoot,
  death,
}

class PatrolBotComponent {
  PatrolBotState currentState = PatrolBotState.walk;
  int hp = 2;
  bool isFacingRight = false;
}
