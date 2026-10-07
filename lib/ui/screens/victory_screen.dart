import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';
import '../widgets/pixel_button.dart';
import '../widgets/pixel_panel.dart';

class VictoryScreen extends StatelessWidget {
  final VoidCallback onPlayAgain;
  final VoidCallback onMainMenu;

  const VictoryScreen({
    super.key,
    required this.onPlayAgain,
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
                'MISSION ACCOMPLISHED',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: GameConstants.colorCyberCyan,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'SIEGE WALKER DESTROYED & OUTPOST SECURED',
                style: TextStyle(
                  fontSize: 12,
                  color: GameConstants.colorPureHighlight,
                ),
              ),
              const SizedBox(height: 20),
              PixelButton(
                label: 'PLAY AGAIN',
                backgroundColor: GameConstants.colorHazardOrange,
                onPressed: onPlayAgain,
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
