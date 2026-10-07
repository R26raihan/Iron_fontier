# IRON FRONTIER — Asset Pack v1

Paket sumber visual untuk prototipe game run-and-gun Flutter. Dibuat menggunakan imagegen bawaan pada 7 Oktober 2026.

## Mulai di sini

- Buka index.html untuk galeri semua gambar.
- inventory.json mencatat dimensi aktual, transparansi, SHA-256, dan lokasi setiap PNG.
- atlas_source_rects.json menyediakan 190 kandidat source rectangle dalam 11 sheet. Koordinat diukur dari alpha, tetapi pembagian semantik, pivot, dan animasi belum diuji dalam engine.
- prompts.md menyimpan prompt lengkap setiap generasi.
- Semua PNG asli dipertahankan. Tidak ada pemotongan, resampling, atau normalisasi bitmap pada paket ini.

## Isi paket

| Folder | File | Isi |
|---|---|---|
| characters | player_core.png | 4 pose/frame per baris: idle, run, jump, shoot |
| characters | player_combat.png | run-shoot, land, hurt, death |
| enemies | patrol_bot.png | idle, walk, shoot, death |
| enemies | hover_drone.png | hover, move, shoot, death |
| enemies | turret.png | idle, charge, shoot, death |
| bosses | siege_walker.png | idle, charge, attack, death |
| backgrounds | sky_far.png | Langit dan awan tanpa bangunan |
| backgrounds | background_landing_cutout.png | Area masuk, versi bangunan dengan langit dihapus |
| backgrounds | background_warehouse.png | Gudang, cutout bangunan |
| backgrounds | background_assembly_cutout.png | Koridor produksi, versi perbaikan |
| backgrounds | background_reactor.png | Reactor cyan, cutout bangunan |
| backgrounds | background_arena_cutout.png | Arena boss, versi perbaikan |
| backgrounds | background_near.png | Struktur dekat dengan ruang transparan di tengah |
| backgrounds | background_sky.png | Panel adegan penuh tambahan; bukan lapisan langit terpisah |
| backgrounds | background_landing.png | Sumber sebelum perbaikan; membawa langit |
| backgrounds | background_assembly.png | Sumber sebelum perbaikan; membawa langit |
| backgrounds | background_arena.png | Sumber sebelum perbaikan; membawa langit |
| environment | foundry_tileset.png | 32 kandidat terrain/panel dalam 8 kolom dan 4 baris |
| environment | foundry_props.png | 16 props: peti, barrel, beacon, pipa, kabel, generator, ventilasi, terminal, lampu, pintu, tiang, crane hook, wreckage |
| effects | combat_effects.png | 24 frame kandidat: peluru cyan, peluru oranye, muzzle cyan, impact, ledakan, debu |
| ui | ui_controls.png | 16 ikon kontrol dan HUD |
| ui | ui_panels.png | 6 komponen dialog, tombol, dan healthbar |
| branding | logo.png | Logo IRON FRONTIER |

## Susunan level dan parallax

Urutan area:
Landing → Warehouse → Assembly → Reactor → Siege Arena.

Usulan gerakan relatif terhadap kamera:
- sky_far: 0.08
- background area: 0.35
- background_near: 0.65
- playable terrain: 1.00

Nilai ini merupakan arahan artistik untuk diuji oleh agent pengembang, bukan konfigurasi engine yang sudah tervalidasi.
Tempatkan langit paling belakang, bangunan area di tengah, lalu terrain serta karakter, dan UI terakhir.
background_near sebaiknya di belakang karakter dahulu; struktur di sampingnya cukup besar dan dapat menutupi permainan bila diletakkan di depan.

Background area memiliki bagian lantai yang digambar. Lantai itu dekorasi: collision dan platform playable harus dibangun terpisah.
Semua cutout dan sky_far memiliki rasio/ukuran aktual berbeda; pertahankan rasio, tentukan skala serta posisi dalam dunia secara eksplisit.
Sambungan kiri-kanan belum diverifikasi seamless. Gunakan panel berurutan dengan transisi yang ditutupi tiang/props atau crossfade.
Jangan menggandakan satu panel berulang tanpa memeriksa garis sambungnya.
Reactor adalah landmark area, hindari pengulangan reactor secara rapat.

## Kontrak untuk agent Flutter

1. Pakai ukuran PNG aktual di inventory.json. Sumber belum berupa frame 48×48 atau tile 32×32.
2. Gunakan atlas_source_rects.json sebagai titik awal pemotongan source rect. Setiap frame mempunyai ukuran berbeda.
3. Jangan langsung membagi sheet menggunakan grid seragam. Jarak frame, ukuran kanvas, dan posisi tidak persis seragam.
4. Gunakan satu faktor skala konsisten untuk satu karakter; jangan menyesuaikan lebar dan tinggi tiap frame secara independen.
5. Tetapkan pivot tubuh/kaki setelah melihat animasi. Saran bottomCenter dalam manifest belum merupakan pivot terukur.
6. Sprite pemain menghadap kanan. Musuh menghadap kiri. Pembalikan horizontal dapat dilakukan di engine.
7. Kaki, nozzle senjata, dan collision box ditetapkan terpisah dari bounding box PNG.
8. Untuk jump, baris jump menyediakan takeoff, rise, apex, fall. Pakai frame tunggal untuk fall jika diperlukan.
9. Muzzle oranye tersedia dalam frame shooting musuh. Efek ledakan dapat digunakan dalam dua skala pada prototipe; belum ada animasi ledakan besar tersendiri.
10. Boss cooldown dapat memakai idle sementara. Paket belum memiliki gerakan cooldown khusus.
11. Teks Start, Pause, Game Over, Victory, dan angka HUD dirender oleh Flutter. Panel yang tersedia menjadi latar bersama.
12. Font tersendiri, audio, ikon aplikasi, splash screen, dan aset store berada di luar paket visual gameplay awal ini.

## Perbedaan dari planning awal

Planning sebelumnya menargetkan 6–8 frame untuk beberapa animasi. Paket generasi v1 menyediakan 4 pose/frame per baris.
Ini memperkecil cakupan animasi prototipe; animasi final dengan target 6–8 frame belum diproduksi.
Gambar konseptual acuan berada di ../concepts/iron-frontier-foundry-v1.png dan bukan bagian dari atlas gameplay.

## Pemeriksaan yang sudah dilakukan

- Semua 23 PNG bisa didekode dan dimensi aktual dicatat.
- Transparansi diperiksa pada setiap PNG.
- Tiga background dengan langit yang tertinggal diperbaiki menggunakan imagegen.
- Source rectangle kandidat memakai koordinat integer dan berada dalam batas gambar.
- Nama file, folder, dan prompt tersimpan.
- Tidak ada integrasi maupun uji animasi Flutter pada tahap ini.

## Pekerjaan sebelum aset dianggap siap rilis

- Rapikan pixel grid dan palet saat aset dikecilkan ke resolusi game.
- Periksa/memperbaiki frame yang menyentuh tepi, termasuk muzzle flash pemain.
- Samakan pivot, foot baseline, panjang rifle, dan proporsi antarframe.
- Uji siklus run: empat pose hasil generasi belum menjamin langkah yang mulus.
- Normalisasi tileset menjadi ukuran tile final dan uji sambungan setiap edge.
- Periksa background pada kamera bergerak dan resolusi layar target.
- Potong komponen UI, uji tombol pada mobile, dan pastikan healthbar fill terpisah dengan benar.
- Buat tambahan frame untuk memenuhi target animasi final setelah prototipe berjalan.

Paket ini lengkap menurut kategori visual MVP, tetapi statusnya adalah sumber aset generasi untuk prototipe, bukan atlas final yang sudah diuji di game.

