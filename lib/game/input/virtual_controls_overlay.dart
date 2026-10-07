import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'game_controls.dart';

/// On-screen D-pad (left) and jump button (right) for touch devices.
///
/// Uses plain styled buttons rather than sliced sprite icons for this stage;
/// wiring real `ui_controls.png` icons in is a follow-up polish pass.
class VirtualControlsOverlay extends StatefulWidget {
  const VirtualControlsOverlay({super.key, required this.inputState});

  final GameInputState inputState;

  @override
  State<VirtualControlsOverlay> createState() => _VirtualControlsOverlayState();
}

class _VirtualControlsOverlayState extends State<VirtualControlsOverlay> {
  void _setTouchHorizontal(double value) {
    setState(() => widget.inputState.touchHorizontal = value);
  }

  void _setJumpHeld(bool held) {
    setState(() => widget.inputState.touchJumpHeld = held);
  }

  void _setShootHeld(bool held) {
    setState(() => widget.inputState.touchShootHeld = held);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left D-Pad Controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ControlButton(
                  icon: Icons.chevron_left,
                  label: 'LEFT',
                  color: GameConstants.colorLightSteel,
                  activeColor: GameConstants.colorCyberCyan,
                  onPressed: (held) => _setTouchHorizontal(held ? -1.0 : 0.0),
                ),
                const SizedBox(width: 14),
                _ControlButton(
                  icon: Icons.chevron_right,
                  label: 'RIGHT',
                  color: GameConstants.colorLightSteel,
                  activeColor: GameConstants.colorCyberCyan,
                  onPressed: (held) => _setTouchHorizontal(held ? 1.0 : 0.0),
                ),
              ],
            ),

            // Right Action Controls (Shoot & Jump)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ControlButton(
                  icon: Icons.gps_fixed,
                  label: 'FIRE',
                  color: GameConstants.colorHazardOrange,
                  activeColor: GameConstants.colorWarningGold,
                  onPressed: _setShootHeld,
                ),
                const SizedBox(width: 16),
                _ControlButton(
                  icon: Icons.arrow_upward,
                  label: 'JUMP',
                  color: GameConstants.colorCyberCyan,
                  activeColor: GameConstants.colorPureHighlight,
                  onPressed: _setJumpHeld,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatefulWidget {
  const _ControlButton({
    required this.icon,
    required this.onPressed,
    this.label,
    this.color = GameConstants.colorLightSteel,
    this.activeColor = GameConstants.colorCyberCyan,
  });

  final IconData icon;
  final String? label;
  final Color color;
  final Color activeColor;
  final void Function(bool held) onPressed;

  @override
  State<_ControlButton> createState() => _ControlButtonState();
}

class _ControlButtonState extends State<_ControlButton> {
  bool _isPressed = false;

  void _handlePress(bool pressed) {
    setState(() => _isPressed = pressed);
    widget.onPressed(pressed);
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = _isPressed ? widget.activeColor : widget.color;

    return GestureDetector(
      onTapDown: (_) => _handlePress(true),
      onTapUp: (_) => _handlePress(false),
      onTapCancel: () => _handlePress(false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 60),
        child: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: GameConstants.colorAbyssalNavy.withAlpha(_isPressed ? 230 : 180),
            border: Border.all(
              color: currentColor,
              width: _isPressed ? 2.5 : 1.8,
            ),
            boxShadow: _isPressed
                ? [
                    BoxShadow(
                      color: currentColor.withAlpha(140),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: currentColor, size: 22),
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: TextStyle(
                    color: currentColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
