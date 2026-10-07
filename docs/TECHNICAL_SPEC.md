# TECHNICAL SPECIFICATION: IRON FRONTIER

## 1. Stack & Dependencies

- **Framework:** Flutter (Channel stable, min Dart SDK `^3.12.x`)
- **Game Engine:** `flame: ^1.20.0` (atau versi kompatibel terbaru)
- **Audio Engine:** `flame_audio: ^2.1.0`
- **Tiled Map Support (Opsional/Rekomendasi):** `flame_tiled: ^1.20.0`
- **State/Event Helpers:** Pure Flame Component architecture (`HasCollisionDetection`, `KeyboardEvents`, `TapCallbacks`, `DragCallbacks`).

---

## 2. Display & Viewport Configuration

- **Virtual Resolution:** `640` (width) × `360` (height)
- **Camera Setup:**
  ```dart
  final camera = CameraComponent.withFixedResolution(
    width: 640,
    height: 360,
  );
  ```
- **Orientation Lock:** Wajib landscape mode pada mobile startup:
  ```dart
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  ```

---

## 3. Komponen & Hirarki Arsitektur (Flame Component Tree)

```text
IronFrontierGame (FlameGame with HasCollisionDetection)
├── CameraComponent (FixedResolution: 640x360)
│   └── Viewport
│       └── World (LevelWorld)
│           ├── ParallaxBackgroundComponent (3 layers, horizontal looping)
│           ├── TileMapComponent / PlatformComponent (Solid hitboxes)
│           ├── HazardZoneComponent (Spikes / Acid pits)
│           ├── PlayerComponent (PositionComponent, CollisionCallbacks)
│           │   ├── PlayerWeaponComponent
│           │   └── RectangleHitbox (20x40 px)
│           ├── EnemyManagerComponent (Spawners & Active Enemy Pool)
│           │   ├── PatrolBotComponent
│           │   ├── HoverDroneComponent
│           │   ├── DefenseTurretComponent
│           │   └── SiegeWalkerBossComponent
│           ├── ProjectilePool (PlayerBullets & EnemyBullets)
│           ├── EffectPool (Explosions, Sparks, Dust)
│           └── LevelTriggerComponent (Boss Arena Lock, Victory Trigger)
└── Overlay / HUD Component Layer
    ├── VirtualJoystick / DPadComponent (Left side)
    ├── ActionButtonsComponent (Jump, Shoot on Right side)
    ├── PlayerHealthHudComponent (Top-left)
    ├── BossHealthBarComponent (Top-center, active during boss fight)
    └── Flutter Overlay UI (PauseMenu, GameOverScreen, VictoryScreen)
```

---

## 4. Parameter Fisika & Logika Gameplay (Constants)

### Parameter Pemain (Player Physics):
```dart
class PlayerConstants {
  static const double moveSpeed = 160.0;       // px / sec
  static const double jumpForce = -340.0;      // px / sec
  static const double gravity = 900.0;         // px / sec^2
  static const double maxFallSpeed = 450.0;    // px / sec
  static const double fireRate = 0.15;         // cooldown antar peluru (detik)
  static const double bulletSpeed = 480.0;     // px / sec
  static const double invincibilityDuration = 1.5; // detik
  static const int maxHp = 3;
}
```

### Parameter Musuh:
```dart
class EnemyConstants {
  // Patrol Bot
  static const double patrolSpeed = 60.0;
  static const double patrolDetectRadius = 200.0;
  static const double patrolFireRate = 1.8;
  static const int patrolHp = 2;

  // Hover Drone
  static const double droneSpeed = 75.0;
  static const double droneWaveAmplitude = 24.0;
  static const double droneFireRate = 2.0;
  static const int droneHp = 2;

  // Turret
  static const double turretChargeDuration = 0.8;
  static const double turretBurstInterval = 0.12;
  static const int turretBurstCount = 3;
  static const int turretHp = 4;

  // Siege Walker (Boss)
  static const int bossHp = 25;
  static const double bossCooldownTime = 2.5;
}
```

---

## 5. Sistem Collision & Hitbox Detection

Flame Engine menggunakan `HasCollisionDetection` dengan tag / category filtering:

| Entity | Hitbox Type | Collides With |
|---|---|---|
| **Player** | `RectangleHitbox` (`20×40 px`) | `PlatformComponent`, `HazardZoneComponent`, `EnemyComponent`, `EnemyBulletComponent` |
| **PlayerBullet** | `RectangleHitbox` (`12×6 px`) | `PlatformComponent` (destroy), `EnemyComponent` (damage), `BossComponent` (damage) |
| **PatrolBot / Drone / Turret** | `RectangleHitbox` (sesuai proporsi tubuh) | `PlatformComponent` (ground logic), `PlayerBullet` (damage) |
| **EnemyBullet** | `RectangleHitbox` (`8×8 px`) | `PlatformComponent` (destroy), `Player` (damage) |
| **Boss (Siege Walker)** | Multiple hitboxes (Legs = Solid/Destructible, Core = Weakpoint) | `PlayerBullet` |

---

## 6. Manifest-Driven Animation System

Semua komponen animasi membaca definisi dari JSON manifest agar rendering terpisah dari engine logic:

```dart
class AnimationLoader {
  static Future<SpriteAnimation> loadFromManifest(String manifestPath) async {
    // 1. Baca manifest JSON
    // 2. Parse frame dimensions, count, stepTime (1 / fps), loop
    // 3. Muat SpriteAnimationData.sequenced(...)
  }
}
```

---

## 7. Sound & Audio Management

- Menggunakan `flame_audio`.
- Preload sound effects pada game init:
  ```dart
  await FlameAudio.audioCache.loadAll([
    'sfx/shoot_player.wav',
    'sfx/shoot_enemy.wav',
    'sfx/explosion_small.wav',
    'sfx/explosion_large.wav',
    'sfx/jump.wav',
    'sfx/hurt.wav',
  ]);
  ```
- Dukung toggle Mute BGM dan SFX via settings/pause menu.
