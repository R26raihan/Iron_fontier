import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';
import '../widgets/pixel_button.dart';
import '../widgets/pixel_panel.dart';

class PauseMenuScreen extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onQuit;

  const PauseMenuScreen({
    super.key,
    required this.onResume,
    required this.onQuit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.colorAbyssalNavy.withAlpha(180),
      body: Center(
        child: PixelPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SYSTEM PAUSED',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: GameConstants.colorWarningGold,
                ),
              ),
              const SizedBox(height: 20),
              PixelButton(label: 'RESUME', onPressed: onResume),
              const SizedBox(height: 12),
              PixelButton(
                label: 'ABORT MISSION',
                backgroundColor: GameConstants.colorHazardOrange,
                onPressed: onQuit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
