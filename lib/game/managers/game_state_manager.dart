enum GamePlayState {
  menu,
  playing,
  paused,
  gameOver,
  victory,
}

class GameStateManager {
  GamePlayState currentState = GamePlayState.menu;
  int score = 0;
  int playerHp = 3;

  void reset() {
    score = 0;
    playerHp = 3;
    currentState = GamePlayState.playing;
  }
}
