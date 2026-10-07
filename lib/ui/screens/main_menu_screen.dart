import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';
import '../widgets/pixel_button.dart';

const String _logoAsset = 'assets/branding/logo.png';
const String _stageBackgroundAsset =
    'assets/environments/foundry/background_landing_cutout.png';

class MainMenuScreen extends StatelessWidget {
  final VoidCallback onStartGame;

  const MainMenuScreen({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.colorAbyssalNavy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _stageBackgroundAsset,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
          // Vignette so the logo/button stay legible over the busy art.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC101722),
                  Color(0x66101722),
                  Color(0xCC101722),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    _logoAsset,
                    width: 420,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '2D RUN-AND-GUN OUTPOST ASSAULT',
                    style: TextStyle(
                      fontSize: 12,
                      color: GameConstants.colorLightSteel,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  PixelButton(
                    label: 'DEPLOY MISSION',
                    backgroundColor: GameConstants.colorHazardOrange,
                    onPressed: onStartGame,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
