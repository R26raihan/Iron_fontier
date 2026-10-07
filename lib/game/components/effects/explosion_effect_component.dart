enum ExplosionType {
  small,
  large,
}

class ExplosionEffectComponent {
  final ExplosionType type;
  ExplosionEffectComponent({this.type = ExplosionType.small});
}
