enum TurretState {
  idle,
  charge,
  shoot,
  destroyed,
}

class TurretComponent {
  TurretState currentState = TurretState.idle;
  int hp = 4;
}
