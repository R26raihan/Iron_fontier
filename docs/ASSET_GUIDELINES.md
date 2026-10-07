# ASSET & VISUAL GUIDELINES: IRON FRONTIER

## 1. Spesifikasi Teknis Rendering & Visual

- **Resolusi Logis Dasar:** `640 × 360 px` (Aspek Rasio 16:9).
- **Pixel Density:** 1:1 Pixel Art murni. Tidak ada sub-pixel scaling atau antialiasing/blur.
- **Tekstur & Filtering:** Selalu render dengan mode **Nearest-Neighbor** (`FilterQuality.none` di Flutter/Flame).
- **Format File:** **PNG-32** (24-bit RGB + 8-bit Alpha Channel transparan).
- **Orientasi Desain:** Karakter dan musuh digambar menghadap ke **kanan**. Gerakan ke kiri dihasilkan melalui horizontal flipping (`scale.x = -1`). *Hindari penulisan teks asimetris pada sprite*.

---

## 2. Palet Warna Resmi (Official Color Palette)

Palet warna telah distandarisasi untuk memaksimalkan kontras dan keterbacaan di layar mobile:

| Kode HEX | Nama Warna | Fungsi & Penggunaan |
|---|---|---|
| `#101722` | **Abyssal Navy** | Latar belakang terjauh, bayangan siluet malam |
| `#283747` | **Dark Steel** | Rangka baja latar, lantai utama, struktur pabrik |
| `#71879B` | **Light Steel** | Platform aktif, tepi dinding yang dapat diinjak |
| `#53E0F2` | **Cyber Cyan** | Visor pemain, energi peluru pemain, lampu aman |
| `#FF7048` | **Hazard Orange** | Peluru musuh, aksen musuh, titik lemah reaktor |
| `#FFD166` | **Warning Gold** | Lampu peringatan pabrik, telegraph serangan boss |
| `#E8F1F5` | **Pure Highlight** | Kilau armor, pantulan proyektil, muzzle flash |

---

## 3. Ukuran Kanvas & Spesifikasi Grid

| Jenis Aset | Ukuran Kanvas Frame | Anchor Point | Keterangan |
|---|---|---|---|
| **Player (IRON Operative)** | `48 × 48 px` | `bottomCenter` | Titik pijak kaki tetap di Y = 46–48 |
| **Patrol Bot** | `48 × 48 px` | `bottomCenter` | Roda menempel di batas bawah |
| **Hover Drone** | `48 × 48 px` | `center` | Bergerak melayang di udara |
| **Defense Turret** | `64 × 64 px` | `bottomCenter` / `center` | Dudukan menempel di lantai/dinding |
| **Siege Walker (Boss)** | `160 × 128 px` | `bottomCenter` | Mech besar berkaki dua |
| **Tiles Lingkungan** | `32 × 32 px` | `topLeft` | Modul lantai, dinding, platform tipis |
| **Ikon HUD & UI** | `16 × 16` / `24 × 24 px` | `center` | Ikon nyawa, indikator peluru, dsb. |
| **Proyektil / FX** | Sesuai efek (`16×16`, `32×32`) | `center` | Peluru, muzzle flash, ledakan |

---

## 4. Struktur Direktori Aset (`assets/`)

```text
assets/
├── audio/
│   ├── bgm/
│   │   └── foundry_theme.ogg
│   └── sfx/
│       ├── shoot_player.wav
│       ├── shoot_enemy.wav
│       ├── explosion_small.wav
│       ├── explosion_large.wav
│       ├── jump.wav
│       └── hurt.wav
├── bosses/
│   └── siege_walker/
│       ├── siege_walker_idle.png
│       ├── siege_walker_charge.png
│       ├── siege_walker_attack.png
│       ├── siege_walker_cooldown.png
│       └── siege_walker_death.png
├── branding/
│   ├── game_logo.png
│   └── studio_splash.png
├── characters/
│   └── player/
│       ├── player_idle.png
│       ├── player_run.png
│       ├── player_jump.png
│       ├── player_fall.png
│       ├── player_land.png
│       ├── player_shoot.png
│       ├── player_run_shoot.png
│       ├── player_hurt.png
│       └── player_death.png
├── effects/
│   ├── bullet_player.png
│   ├── bullet_enemy.png
│   ├── fx_muzzle_flash.png
│   ├── fx_spark.png
│   ├── fx_explosion_small.png
│   ├── fx_explosion_large.png
│   └── fx_dust_land.png
├── enemies/
│   ├── hover_drone/
│   │   ├── drone_hover.png
│   │   ├── drone_shoot.png
│   │   └── drone_death.png
│   ├── patrol_bot/
│   │   ├── patrol_idle.png
│   │   ├── patrol_walk.png
│   │   ├── patrol_shoot.png
│   │   └── patrol_death.png
│   └── turret/
│       ├── turret_idle.png
│       ├── turret_charge.png
│       ├── turret_shoot.png
│       └── turret_destroyed.png
├── environments/
│   └── foundry/
│       ├── foundry_tileset.png
│       ├── bg_sky_city.png
│       ├── bg_mid_structures.png
│       └── bg_near_scaffold.png
├── manifests/
│   ├── player_animations.json
│   ├── enemies_animations.json
│   └── boss_animations.json
└── ui/
    ├── hud_health_icon.png
    ├── hud_boss_bar.png
    ├── btn_joystick_base.png
    ├── btn_joystick_knob.png
    ├── btn_jump.png
    ├── btn_shoot.png
    └── panel_dialog.png
```

---

## 5. Standar Format Sprite Sheet & Metadata JSON

### Aturan Pembuatan Sprite Sheet:
1. **Horizontal Single Strip:** Seluruh frame disusun 1 baris mendatar dari kiri ke kanan.
2. **Ukuran Seragam:** Setiap frame memiliki lebar dan tinggi kanvas yang identik (misal: 8 frame berukuran `48×48 px` menghasilkan file gambar berukuran `384 × 48 px`).
3. **No Padding:** Tidak ada margin atau padding pixel di antara frame.
4. **Baseline Konsisten:** Titik tumpu kaki pemain tidak boleh naik-turun pada animasi run/idle kecuali gerakan dimaksudkan demikian.
5. **No Watermark/Grid:** Tidak ada nomor frame, garis grid, atau label teks pada gambar final.

### Skema Manifest JSON:
```json
{
  "id": "player_run",
  "file": "assets/characters/player/player_run.png",
  "frameWidth": 48,
  "frameHeight": 48,
  "frameCount": 8,
  "fps": 12,
  "loop": true,
  "anchor": "bottomCenter",
  "hitbox": {
    "offsetX": 14,
    "offsetY": 8,
    "width": 20,
    "height": 40
  }
}
```

---

## 6. Daftar Kebutuhan Aset Berdasarkan Prioritas

### Prioritas A — Style Definitive Pack (Kunci Visual)
- [ ] Desain tampak samping karakter utama (Player concept & palette sample).
- [ ] Desain musuh Patrol Bot.
- [ ] 1 Sample Tileset (Lantai, Platform tipis, Dinding baja).
- [ ] 1 Mockup adegan permainan (Foundry Outpost dengan Player, Enemy, Parallax BG, dan HUD).

### Prioritas B — Animasi Karakter Pemain
- [ ] `player_idle.png` (4 frames, loop: true)
- [ ] `player_run.png` (8 frames, loop: true)
- [ ] `player_jump.png` (2 frames, loop: false)
- [ ] `player_fall.png` (2 frames, loop: true)
- [ ] `player_land.png` (3 frames, loop: false)
- [ ] `player_shoot.png` (3 frames, loop: false)
- [ ] `player_run_shoot.png` (8 frames, loop: true)
- [ ] `player_hurt.png` (2 frames, loop: false)
- [ ] `player_death.png` (6 frames, loop: false)

### Prioritas C — Animasi Musuh & Boss
- [ ] **Patrol Bot:** Idle (4), Walk (6), Shoot (3), Death (5)
- [ ] **Hover Drone:** Hover (4), Shoot (3), Death (5)
- [ ] **Defense Turret:** Idle (1), Charge (3), Shoot (3), Destroyed (1)
- [ ] **Siege Walker (Boss):** Idle (4), Charge (4), Attack (4), Cooldown (4), Death (8)

### Prioritas D — Visual FX & Proyektil
- [ ] Peluru cyan pemain (`16 × 8 px`) & Muzzle Flash
- [ ] Peluru oranye musuh (`12 × 12 px`) & Charge Glow
- [ ] Percikan benturan (Sparks)
- [ ] Ledakan kecil (`32 × 32 px`, 6 frames)
- [ ] Ledakan besar boss (`64 × 64 px`, 8 frames)
- [ ] Efek debu mendarat (`24 × 12 px`, 4 frames)

### Prioritas E — Tileset Lingkungan & Parallax
- [ ] Tileset Foundry (`32 × 32 px` auto-tile kompatibel)
- [ ] Background Layer 1: Far Sky & Megastructure Silhouettes
- [ ] Background Layer 2: Mid-distance factory piping & steam vents
- [ ] Background Layer 3: Near structural trusses

### Prioritas F — UI Assets
- [ ] Logo judul (Pixel Art "IRON FRONTIER")
- [ ] HUD: Ikon HP Pemain (Cyan Battery/Shield), Boss HP Bar Frame & Fill
- [ ] Virtual Button Sprites (D-Pad, Jump, Shoot, Pause)
- [ ] Frame panel Menu, Game Over, & Victory Dialog
