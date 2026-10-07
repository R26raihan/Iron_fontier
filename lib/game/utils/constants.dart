import 'dart:ui';

/// Game-wide design constants for IRON FRONTIER
class GameConstants {
  // Logical Viewport (16:9)
  static const double resolutionWidth = 640.0;
  static const double resolutionHeight = 360.0;
  static const double targetFps = 60.0;

  // Official 7-Color Palette
  static const Color colorAbyssalNavy = Color(0xFF101722);
  static const Color colorDarkSteel = Color(0xFF283747);
  static const Color colorLightSteel = Color(0xFF71879B);
  static const Color colorCyberCyan = Color(0xFF53E0F2);
  static const Color colorHazardOrange = Color(0xFFFF7048);
  static const Color colorWarningGold = Color(0xFFFFD166);
  static const Color colorPureHighlight = Color(0xFFE8F1F5);
}

/// Player physics and combat configurations
class PlayerConstants {
  static const double canvasSize = 48.0;
  static const double hitboxWidth = 20.0;
  static const double hitboxHeight = 40.0;

  static const double moveSpeed = 160.0;
  static const double jumpForce = -340.0;
  static const double gravity = 900.0;
  static const double maxFallSpeed = 450.0;

  static const double fireRate = 0.15; // Delay in seconds between shots
  static const double bulletSpeed = 480.0;
  static const double invincibilityDuration = 1.5;
  static const int maxHp = 3;
}

/// Enemy physics and combat parameters
class EnemyConstants {
  // Patrol Bot
  static const double patrolCanvasSize = 48.0;
  static const double patrolSpeed = 60.0;
  static const double patrolDetectRadius = 200.0;
  static const double patrolFireRate = 1.8;
  static const int patrolHp = 2;

  // Hover Drone
  static const double droneCanvasSize = 48.0;
  static const double droneSpeed = 75.0;
  static const double droneWaveAmplitude = 24.0;
  static const double droneFireRate = 2.0;
  static const int droneHp = 2;

  // Defense Turret
  static const double turretCanvasSize = 64.0;
  static const double turretChargeDuration = 0.8;
  static const double turretBurstInterval = 0.12;
  static const int turretBurstCount = 3;
  static const int turretHp = 4;

  // Siege Walker (Boss)
  static const double bossWidth = 160.0;
  static const double bossHeight = 128.0;
  static const int bossHp = 25;
  static const double bossCooldownTime = 2.5;
}
