import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../game/input/virtual_controls_overlay.dart';
import '../../game/iron_frontier_game.dart';
import '../hud/game_hud.dart';
import 'pause_menu_screen.dart';

/// Hosts the Flame [GameWidget] plus the Flutter-rendered HUD, touch
/// controls, and pause overlay on top of it.
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final IronFrontierGame _game = IronFrontierGame();
  bool _isPaused = false;

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _game.pauseEngine();
    } else {
      _game.resumeEngine();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: GameWidget(game: _game)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GameHud(
              playerHp: _game.stateManager.playerHp,
              onPausePressed: _togglePause,
            ),
          ),
          if (!_isPaused)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VirtualControlsOverlay(inputState: _game.inputState),
            ),
          if (_isPaused)
            PauseMenuScreen(
              onResume: _togglePause,
              onQuit: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
}
