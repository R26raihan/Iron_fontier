import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';

class PixelPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PixelPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: GameConstants.colorAbyssalNavy.withAlpha(230),
        border: Border.all(color: GameConstants.colorLightSteel, width: 3),
      ),
      child: child,
    );
  }
}
