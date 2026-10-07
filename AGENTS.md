# PROJECT: IRON FRONTIER
> 2D Pixel Art Side-Scrolling Run-and-Gun Action Game built with Flutter & Flame Engine.

---

## 🤖 Instructions for AI Agents (Agent Rules & Context)

Semua AI Agent (Developer Agent, Asset Artist Agent, Sound Agent, QA Agent) yang bekerja di repositori ini **WAJIB** membaca dan mematuhi seluruh spesifikasi di bawah ini sebelum membuat kode atau aset.

### 📌 Core Project Summary
- **Game Title:** IRON FRONTIER
- **Genre:** 2D Side-Scrolling Run & Gun / Action Platformer (Inspirasi: *Contra*)
- **Target Platform:** Android (Landscape orientation, logical viewport **640 × 360**)
- **Core Engine:** Flutter + Flame Game Engine (`flame: ^1.x`, `flame_audio: ^2.x`)
- **Visual Style:** Sharp Pixel Art (Nearest-Neighbor, consistent pixel grid, modern palette)
- **Scope Version 1:** 1 playable level (*Foundry Outpost*), 1 player character, 1 primary weapon, 3 regular enemy types, 1 boss (*Siege Walker*), HUD, Menu, Pause, Game Over, Win screen (3–5 menit playtime).

---

## 🧭 Documentation Map

| Dokumen | Deskripsi | Link |
|---|---|---|
| **Game Design Document (GDD)** | Visi, premis, gameplay, musuh, level, dan kontrol | [docs/GDD.md](file:///Users/raihansetiawan/firstgame/docs/GDD.md) |
| **Technical Specification** | Arsitektur Flutter/Flame, struktur class, input, collision, audio | [docs/TECHNICAL_SPEC.md](file:///Users/raihansetiawan/firstgame/docs/TECHNICAL_SPEC.md) |
| **Asset & Visual Guidelines** | Palet warna, spesifikasi canvas, format sprite sheet & manifest JSON | [docs/ASSET_GUIDELINES.md](file:///Users/raihansetiawan/firstgame/docs/ASSET_GUIDELINES.md) |
| **Roadmap & Agent Tasks** | Pembagian tugas Developer vs Artist, tahapan fase 1–5, DoD | [docs/ROADMAP.md](file:///Users/raihansetiawan/firstgame/docs/ROADMAP.md) |

---

## 🎯 Role Guidelines for AI Agents

### 1. Developer Agent (Game Logic & Engine)
- **Engine Setup:** Gunakan Flutter dengan Flame Game Engine. Pastikan resolusi virtual terkunci pada `640 × 360` menggunakan `FixedResolutionViewport` atau `CameraComponent.withFixedResolution`.
- **Placeholder First:** Gunakan placeholder hitbox/color-block berukuran presisi sesuai tabel aset sebelum sprite final tersedia.
- **Decoupled Architecture:** Pisahkan sistem input, physics/collision, combat/health, dan animation playback agar mudah diuji secara modular.
- **Sprite Animation Manifest:** Muat animasi menggunakan data JSON metadata (lihat [docs/ASSET_GUIDELINES.md](file:///Users/raihansetiawan/firstgame/docs/ASSET_GUIDELINES.md)) agar pergantian aset tidak merusak kode.
- **Mobile Controls:** Implementasikan virtual joystick / d-pad (kiri/kanan) di kiri layar, tombol Jump & Shoot di kanan layar, serta tombol Pause di sudut atas. Dukung autofire saat tombol Shoot ditahan.

### 2. Asset Artist Agent (Sprites, Tiles, & UI)
- **Pixel Grid & Filtering:** Semua sprite wajib memiliki rasio pixel murni 1:1, diekspor dalam PNG transparan, tanpa antialiasing/blur.
- **Canvas Sizing:**
  - Player: `48 × 48 px`
  - Patrol Bot: `48 × 48 px`
  - Hover Drone: `48 × 48 px`
  - Defense Turret: `64 × 64 px`
  - Siege Walker (Boss): `160 × 128 px`
  - Environment Tiles: `32 × 32 px`
- **Sprite Sheet Layout:** Horizontal strip (1 row, N frames), tanpa padding antar-frame, anchor konsisten di `bottomCenter`.
- **Visual Clarity:** Karakter & peluru pemain (`#53E0F2` Cyan) harus sangat kontras dengan latar belakang industri gelap (`#101722`, `#283747`) dan musuh/bahaya (`#FF7048` Orange-Red).

---

## 📁 Directory Structure Standard

```text
lib/
  ├── main.dart                   # Entry point, orientation lock, window setup
  ├── game/
  │   ├── iron_frontier_game.dart # Main FlameGame instance & routing
  │   ├── components/             # Reusable Flame components
  │   │   ├── player/             # Player physics, state, weapon
  │   │   ├── enemies/            # Patrol Bot, Hover Drone, Turret, Siege Walker
  │   │   ├── projectiles/        # Player bullet, enemy projectile
  │   │   ├── effects/            # Explosions, muzzle flash, hit sparks
  │   │   └── environment/        # Platforms, hazard zones, doors
  │   ├── levels/                 # Level loader (Foundry Outpost tilemap/spawners)
  │   ├── input/                  # Virtual joystick, on-screen buttons, keyboard fallback
  │   ├── managers/               # Audio, Score, State, Save/Config
  │   └── utils/                  # Constants, sprite manifest parser, helpers
  └── ui/
      ├── hud/                    # Health icon, boss HP bar, score
      ├── screens/                # Main Menu, Pause, Game Over, Victory
      └── widgets/                # Custom styled UI panels & buttons

assets/
  ├── audio/                      # SFX & BGM
  ├── branding/                   # Logos & splash
  ├── characters/player/          # Player sprite sheets
  ├── enemies/                    # Enemy sprite sheets by subfolder
  ├── bosses/                     # Boss sprite sheets
  ├── effects/                    # Combat FX sheets
  ├── environments/foundry/       # Tilesets & parallax layers
  ├── ui/                         # UI icons & panels
  └── manifests/                  # JSON animation metadata files
```

---

## ⚡ Quick Rules for Future Prompts
Ketika Anda (AI Agent) diminta mengerjakan fitur baru:
1. Cek [docs/GDD.md](file:///Users/raihansetiawan/firstgame/docs/GDD.md) untuk memastikan mekanika sesuai visi.
2. Cek [docs/ASSET_GUIDELINES.md](file:///Users/raihansetiawan/firstgame/docs/ASSET_GUIDELINES.md) untuk ukuran canvas dan ID aset.
3. Selalu perbarui status task di [docs/ROADMAP.md](file:///Users/raihansetiawan/firstgame/docs/ROADMAP.md).
