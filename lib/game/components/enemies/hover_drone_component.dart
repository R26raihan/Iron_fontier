enum HoverDroneState {
  hover,
  shoot,
  death,
}

class HoverDroneComponent {
  HoverDroneState currentState = HoverDroneState.hover;
  int hp = 2;
}
