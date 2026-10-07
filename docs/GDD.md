# GAME DESIGN DOCUMENT: IRON FRONTIER

## 1. Visi Game
**IRON FRONTIER** adalah game aksi pixel art side-scrolling 2D untuk platform mobile (Flutter). Pemain bergerak cepat, melompat, menembak musuh, menghindari serangan proyektil, dan menghadapi pertarungan boss di akhir level.

- **Inspirasi Gameplay:** Genre run-and-gun klasik seperti *Contra* dan *Metal Slug*, namun dengan karakter, dunia sci-fi industri, musuh, dan aset 100% orisinal.
- **Arah Visual:** Memadukan bentuk pixel art tegas dengan palet warna modern, latar belakang multi-layer parallax, efek pencahayaan, dan efek pertempuran ekspresif.
- **Prinsip Utama:** Keterbacaan karakter (player readability), proyektil peluru, dan bahaya lingkungan selalu lebih diutamakan daripada ornamen dekorasi latar.

---

## 2. Premis dan Identitas
Di sebuah koloni industri luar angkasa, jaringan pertahanan otomatis mengalami malfungsi kritis, mengambil alih seluruh fasilitas dan memburu manusia yang tersisa. Pemain adalah prajurit elite dari unit **IRON** yang ditugaskan menerobos masuk untuk mematikan reaktor pusat kendali.

- **Karakter Utama (IRON Operative):** Menggunakan armor ringan warna abu-abu kebiruan, helm dengan visor cyan menyala, dan senapan energi berkecepatan tinggi.
- **Musuh:** Memiliki aksen warna oranye-merah terang (`#FF7048`) sehingga pemain dapat membedakan musuh dan ancaman dalam sepersekian detik.
- **Tema Lingkungan Level 1 (Foundry Outpost):** Kompleks industri di malam hari dengan struktur baja gelap, lampu peringatan berkedip, jalinan kabel dan pipa uap bertekanan tinggi, serta mesin pabrik aktif.
- **Nuansa & Tone:** Intens, futuristik, cepat, dan heroik.

---

## 3. Target dan Ruang Lingkup (Scope V1)

- **Target Platform:** Android (Landscape orientation, logical resolution `640 × 360`).
- **Durasi Sesi V1:** 1 level pendek selesai dari awal hingga akhir dalam durasi sekitar **3–5 menit**.

### Fitur Versi 1 (In-Scope):
1. **Pemain:** 1 karakter (IRON Operative) dengan sistem gerakan responsif, lompat, dan tembak.
2. **Senjata:** 1 senapan energi utama dengan peluru cyan autofire.
3. **Musuh:** 3 tipe musuh reguler (Patrol Bot, Hover Drone, Defense Turret).
4. **Boss:** 1 Boss arena di akhir level (Siege Walker) dengan multi-phase attack pattern.
5. **Lingkungan:** 1 level terpadu (Foundry Outpost) berbasis tilemap modular dan 3 layer background parallax.
6. **UI/UX:** Virtual Touch Controls (Joystick/Buttons), In-Game HUD (Health & Boss HP), Main Menu, Pause Menu, Game Over Screen, dan Victory Screen.

### Di Luar Ruang Lingkup V1 (Out-of-Scope):
- Multiplayer / Co-op.
- Inventory system & multiple weapon select.
- Skill tree / RPG progression.
- Karakter ganda yang dapat dipilih.
- Procedural level generation.

---

## 4. Sistem Gameplay & Mekanika

### Alur Permainan (Core Game Loop)
```text
[Main Menu] ➔ [Masuk Level: Foundry Outpost] ➔ [Navigasi Platform & Combat] 
            ➔ [Pintu Reaktor / Arena Boss] ➔ [Pertarungan Siege Walker] 
            ➔ [Kemenangan / Victory Screen] (atau [Game Over Screen] ➔ [Restart])
```

### Kontrol Mobile (Touch Screen Layout)
- **Sisi Kiri:** Tombol Arah Horizontal (Kiri / Kanan) atau Virtual D-Pad responsif.
- **Sisi Kanan:** 
  - Tombol **Lompat (Jump)**.
  - Tombol **Tembak (Shoot)** — Menahan tombol menghasilkan tembakan berulang (autofire).
- **Pojok Kanan/Kiri Atas:** Tombol **Pause**.
- **Mekanika Bidikan Prototipe:** Tembakan horizontal searah hadap karakter (kiri/kanan). Sistem bidikan diagonal dapat ditambahkan sebagai peningkatan pasca-prototipe.

### Sistem Pertempuran & Nyawa (Health & Combat System)
- **Health Pemain:** Pemain memiliki **3 Poin Nyawa (HP)** yang ditampilkan pada HUD.
- **Invincibility Frame (I-Frames):** Saat terkena serangan, pemain kebal selama 1.5 detik dengan efek visual berkedip (blinking/flashing).
- **Environmental Hazard:** Jatuh ke jurang atau genangan racun/reaktor memicu respawn pada checkpoint platform terdekat dan mengurangi 1 HP.
- **Senjata Pemain:** Menembakkan proyektil energi cyan horizontal berkecepatan tinggi. Laju tembakan (fire rate) ditentukan oleh variabel timer di logic, independen dari durasi animasi.

---

## 5. Karakter, Musuh, & Boss

### 1. Pemain: IRON Operative
- Siluet ringkas, gesit, dan atletis.
- Armor abu-abu kebiruan dengan visor cyan menyala.
- Ukuran kanvas: `48 × 48 px`.

### 2. Musuh 1: Patrol Bot
- Robot patroli darat berkaki roda/treads yang berjalan bolak-balik di platform.
- Mendeteksi pemain pada jarak tertentu, berhenti, dan menembak proyektil horizontal oranye.
- Ukuran kanvas: `48 × 48 px`. HP: 2 peluru.

### 3. Musuh 2: Hover Drone
- Drone terbang yang melayang di udara menjaga area vertikal.
- Bergerak secara sinusoidal dan menembakkan proyektil ke arah pemain secara berkala.
- Ukuran kanvas: `48 × 48 px`. HP: 1–2 peluru.

### 4. Musuh 3: Defense Turret
- Turret statis terpasang di dinding atau platform tinggi yang mengunci koridor tembakan.
- Memiliki fase persiapan visual (charge animation dengan lampu oranye) sebelum menembakkan rentetan peluru cepat.
- Ukuran kanvas: `64 × 64 px`. HP: 4 peluru.

### 5. Boss: Siege Walker
- Mesin tempur raksasa berkaki dua (mech) dengan reaktor energi oranye di dadanya.
- Ukuran kanvas: `160 × 128 px`. HP: 20–30 peluru.
- **Pola Serangan:**
  1. *Horizontal Barrage:* Rentetan tembakan peluru berat mendatar.
  2. *Spread Volley:* Tembakan menyebar (3 peluru) dengan visual telegraph (ancang-ancang).
  3. *Cooldown Phase:* Jeda pendinginan mesin selama beberapa detik (titik lemah terbuka untuk diserang).

---

## 6. Struktur Level: Foundry Outpost

Level dibagi menjadi 5 segmen tematik yang bersambung:

1. **Landing Zone:** Area perkenalan gerakan dasar, lompatan platform sederhana, dan mekanika menembak.
2. **Factory Approach:** Kemunculan Patrol Bot pertama, navigasi platform berundak rendah, dan pipa uap.
3. **Assembly Corridor:** Pertarungan gabungan antara Hover Drone di udara dan Defense Turret di sudut platform.
4. **Reactor Gate:** Pertempuran intens dengan gelombang musuh terakhir sebelum memasuki gerbang reaktor utama.
5. **Siege Arena:** Arena boss datar dengan platform samping untuk manuver lompat dan menghindar dari serangan Siege Walker.

---

## 7. Audio & SFX (Perencanaan Suara)
- **Musik Latar (BGM):** Synthwave / Cyberpunk tempo cepat (130–140 BPM) dengan bass bertenaga.
- **SFX:**
  - Laser shot pemain (sharp energy blast).
  - Tembakan proyektil musuh (heavy plasma sound).
  - Ledakan musuh (crunchy 8-bit / 16-bit explosion).
  - Suara lompat, mendarat (footstep metal), dan terkena hit (damage alert).
