enum SiegeWalkerState {
  idle,
  charge,
  attack,
  cooldown,
  death,
}

class SiegeWalkerBossComponent {
  SiegeWalkerState currentState = SiegeWalkerState.idle;
  int hp = 25;
}
