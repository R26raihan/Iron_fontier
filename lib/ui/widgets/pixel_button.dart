import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';

class PixelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const PixelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = GameConstants.colorDarkSteel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(minWidth: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: GameConstants.colorPureHighlight, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: GameConstants.colorPureHighlight,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
