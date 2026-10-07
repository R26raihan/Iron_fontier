import 'package:flutter/material.dart';
import '../../game/utils/constants.dart';

class GameHud extends StatelessWidget {
  final int playerHp;
  final int bossHp;
  final bool showBossBar;
  final VoidCallback onPausePressed;

  const GameHud({
    super.key,
    required this.playerHp,
    this.bossHp = 25,
    this.showBossBar = false,
    required this.onPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Player HP Indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: GameConstants.colorAbyssalNavy.withAlpha(210),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: GameConstants.colorLightSteel.withAlpha(120),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'HP',
                    style: TextStyle(
                      color: GameConstants.colorCyberCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ...List.generate(3, (index) {
                    final isFull = index < playerHp;
                    return Container(
                      margin: const EdgeInsets.only(right: 4),
                      width: 18,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isFull
                            ? GameConstants.colorCyberCyan
                            : GameConstants.colorDarkSteel.withAlpha(100),
                        border: Border.all(
                          color: isFull
                              ? GameConstants.colorPureHighlight
                              : GameConstants.colorDarkSteel,
                          width: 1,
                        ),
                        boxShadow: isFull
                            ? [
                                BoxShadow(
                                  color: GameConstants.colorCyberCyan.withAlpha(120),
                                  blurRadius: 4,
                                  spreadRadius: 0.5,
                                ),
                              ]
                            : null,
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Pause Button
            GestureDetector(
              onTap: onPausePressed,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: GameConstants.colorAbyssalNavy.withAlpha(210),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: GameConstants.colorLightSteel.withAlpha(160),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.pause,
                  color: GameConstants.colorPureHighlight,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
