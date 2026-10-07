import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';
import '../widgets/pixel_button.dart';
import '../widgets/pixel_panel.dart';

class GameOverScreen extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onMainMenu;

  const GameOverScreen({
    super.key,
    required this.onRetry,
    required this.onMainMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.colorAbyssalNavy.withAlpha(220),
      body: Center(
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'OPERATIVE DOWN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: GameConstants.colorHazardOrange,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'SIGNAL LOST IN FOUNDRY OUTPOST',
                style: TextStyle(
                  fontSize: 12,
                  color: GameConstants.colorLightSteel,
                ),
              ),
              const SizedBox(height: 20),
              PixelButton(
                label: 'REDEPLOY',
                backgroundColor: GameConstants.colorCyberCyan.withAlpha(200),
                onPressed: onRetry,
              ),
              const SizedBox(height: 12),
              PixelButton(label: 'MAIN MENU', onPressed: onMainMenu),
            ],
          ),
        ),
      ),
    );
  }
}
