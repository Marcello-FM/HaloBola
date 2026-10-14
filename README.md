# HalaBola ⚽ — Aplikasi Kuis Sepak Bola Interaktif

## a. Identitas Mahasiswa

| Field | Keterangan |
| :--- | :--- |
| **Nama** | Marcello Frans Mardohae Pakpahan |
| **NIM** | 241401104 |
| **Lab** | Pemrograman Mobile — PM 4 (LAB 4) |
| **Mata Kuliah** | Praktikum Pemrograman Mobile |
| **Tugas** | Proyek UTS (Individual Take-Home) |

---

## b. Informasi Aplikasi

### i. Nama Aplikasi
**HalaBola**

### ii. Deskripsi Singkat Aplikasi
**HalaBola** adalah aplikasi kuis pilihan ganda (*multiple-choice*) bertema sepak bola yang dibangun menggunakan *framework* Flutter. Pengguna dapat memasukkan nama pemain, memilih satu dari empat kategori kuis beserta tingkat kesulitannya, lalu menjawab rangkaian pertanyaan dengan batas waktu (*countdown timer*) layaknya pertandingan sepak bola. Di akhir permainan, aplikasi menampilkan skor akhir, akurasi, predikat pemain, evaluasi jawaban lengkap, serta mencatat skor pada papan klasemen (*leaderboard*).

### iii. Fitur-Fitur yang Tersedia

#### Fitur Utama (Kriteria Wajib)
- **Welcome Screen & Validasi Input:** Halaman awal dilengkapi animasi logo bola memantul dan validasi *input* nama pemain (tidak boleh kosong dan minimal 2 karakter).
- **Pemilihan Kategori & Level Kesulitan:** Tersedia 4 kategori kuis (*Sejarah Piala Dunia*, *Timnas Indonesia*, *Aturan & Istilah Sepak Bola*, serta *Legenda & Rekor*) dan 3 tingkat kesulitan (*Mudah*, *Sedang*, *Sulit*) dengan penghitung jumlah soal otomatis.
- **Halaman Kuis Dinamis & Timer 20 Detik:** Satu halaman kuis *reusable* yang menampilkan progres menit pertandingan, *countdown timer* melingkar 20 detik per soal dengan indikator perubahan warna, serta pengacakan urutan soal maupun opsi jawaban di setiap sesi.
- **Feedback Interaktif & Penjelasan Fakta:** Dilengkapi animasi tombol (*shake* saat salah, *pop* saat benar), *banner* status komentator sepak bola (*"GOL!"*, *"Offside!"*, atau *"Waktu Habis, Kartu Kuning!"*), serta kartu penjelasan fakta di setiap soal.
- **Papan Skor & Review Pertandingan (`Result Screen`):** Menampilkan skor akhir dari nama pemain, persentase akurasi, gelar/predikat pemain (hingga *Ballon d'Or*), animasi perayaan *confetti* untuk skor $\ge 75\%$, serta daftar evaluasi jawaban (jawaban pemain vs jawaban benar).
- **Papan Klasemen (`Leaderboard Screen`):** Menyimpan dan mengurutkan riwayat skor pemain tertinggi selama sesi penggunaan aplikasi berjalan.

#### Fitur Bonus & Keunggulan Teknis
- **Dual-Theme (Light & Dark Mode):** Mendukung pergantian tema terang dan gelap secara *real-time* dari setiap halaman menggunakan `ThemeToggleButton` dan `ThemeProvider`.
- **Adaptive & Responsive Design:** Tata letak otomatis menyesuaikan ukuran layar perangkat menggunakan *helper* `Responsive` (`MediaQuery` berbasis `wp`, `hp`, dan `sp` tanpa nilai ukuran yang di-*hardcode*). Mendukung tampilan 1 kolom pada *Smartphone Portrait* dan otomatis beralih menjadi tata letak 2 kolom berdampingan pada *Landscape*, *Tablet*, maupun *Web Browser*.
- **State Management (`Provider`):** Seluruh progres kuis, *timer*, skor, dan tema dikelola menggunakan `ChangeNotifierProvider` (`QuizProvider` & `ThemeProvider`), sehingga progres pemain tidak hilang saat layar perangkat dirotasi atau berpindah halaman.
- **Custom Route Transitions:** Navigasi antar-halaman menggunakan `PageRouteBuilder` dengan animasi transisi `FadeTransition` dan `SlideTransition`.

---

## c. Dokumentasi

### i. Credit Sumber Aset & Paket

#### Font Kustom (`assets/fonts/`)
| Nama Font | Variasi | Sumber | Lisensi |
| :--- | :--- | :--- | :--- |
| **Oswald** | Regular (400), Bold (700) | [Google Fonts - Oswald](https://fonts.google.com/specimen/Oswald) | SIL Open Font License 1.1 |
| **Poppins** | Regular (400), Medium (500), SemiBold (600), Bold (700) | [Google Fonts - Poppins](https://fonts.google.com/specimen/Poppins) | SIL Open Font License 1.1 |

#### Gambar, Ikon & Ilustrasi (`assets/images/` & `assets/icons/`)
- **Gambar Bola Utama (`assets/images/ball.png`):** Aset gambar bola sepak pada logo utama aplikasi (`AppLogo`).
- **Ikon Antarmuka:** Menggunakan *Material Icons* bawaan Flutter (`Icons.sports_soccer`, `Icons.emoji_events_rounded`, `Icons.leaderboard_rounded`, dll.).
- **Ilustrasi Latar & Efek Visual:** Dibuat secara terprogram menggunakan Flutter `CustomPainter` pada `PitchBackground` (garis lapangan sepak bola) dan `ConfettiOverlay` (animasi partikel perayaan).

#### Paket (Dependencies)
- [`provider: ^6.1.2`](https://pub.dev/packages/provider) — State management aplikasi.
- [`cupertino_icons: ^1.0.8`](https://pub.dev/packages/cupertino_icons) — Dukungan ikon dasar.

---

### ii. Screenshot Tiap Halaman Aplikasi

> *Catatan: Simpan gambar tangkapan layar ke dalam folder `screenshots/` di proyek, lalu sesuaikan nama filenya pada tabel di bawah ini.*

| Halaman | Tampilan Aplikasi |
| :--- | :---: |
| **1. Welcome Screen (Light & Dark)** | ![Welcome Screen](screenshots/welcome.png) |
| **2. Category & Difficulty Screen** | ![Category Screen](screenshots/category.png) |
| **3. Quiz Screen (Portrait)** | ![Quiz Portrait](screenshots/quiz_portrait.png) |
| **4. Quiz Screen (Feedback & Penjelasan)** | ![Quiz Answered](screenshots/quiz_answered.png) |
| **5. Quiz Screen (Responsive Landscape / Web)** | ![Quiz Landscape](screenshots/quiz_landscape.png) |
| **6. Result & Review Screen** | ![Result Screen](screenshots/result.png) |
| **7. Leaderboard Screen (Klasemen)** | ![Leaderboard Screen](screenshots/leaderboard.png) |

---

### iii. Link Mockup / Prototype Aplikasi
- **Desain Mockup / Prototype (Figma):** [Klik di sini untuk melihat Prototype Figma HalaBola](https://www.figma.com/) *(Ganti URL ini dengan link Figma milikmu)*

---

## Struktur Proyek

```text
lib/
├── main.dart                          # Entry point aplikasi & konfigurasi MultiProvider
├── core/
│   ├── constants.dart                 # Konstanta aplikasi, daftar kategori & tingkat kesulitan
│   ├── responsive.dart                # Helper responsivitas layar (MediaQuery wp, hp, sp)
│   ├── routes.dart                    # Pengaturan named routes & animasi transisi halaman
│   ├── strings.dart                   # Kumpulan teks UI & logika predikat skor akhir
│   └── theme.dart                     # Palet warna (AppColors), bentuk (AppShapes), Light & Dark Theme
├── models/
│   ├── question.dart                  # Model data Question
│   └── quiz_result.dart               # Model AnswerRecord, QuizResult, dan LeaderboardEntry
├── data/
│   └── questions_data.dart            # Data lokal berisi 48 soal kuis sepak bola
├── providers/
│   ├── quiz_provider.dart             # State management kuis, pengacakan soal, timer, & klasemen
│   └── theme_provider.dart            # State management untuk pergantian Light & Dark mode
├── screens/
│   ├── welcome_screen.dart            # Halaman input nama pemain
│   ├── category_screen.dart           # Halaman pemilihan kategori & tingkat kesulitan
│   ├── quiz_screen.dart               # Halaman utama kuis (mendukung layout narrow & wide)
│   ├── result_screen.dart             # Halaman hasil skor, akurasi, & review jawaban
│   └── leaderboard_screen.dart        # Halaman papan klasemen pemain
└── widgets/
    ├── answer_option_button.dart      # Tombol opsi jawaban dengan animasi shake & pop
    ├── answer_review_item.dart        # Kartu item evaluasi jawaban di halaman hasil
    ├── app_logo.dart                  # Widget logo HalaBola dengan gambar aset & animasi bounce
    ├── category_card.dart             # Kartu pilihan kategori kuis
    ├── confetti_overlay.dart          # Efek animasi partikel confetti menggunakan CustomPainter
    ├── hb_button.dart                 # Tombol utama reusable dengan animasi tekan (scale)
    ├── pitch_background.dart          # Latar belakang garis lapangan bola (CustomPainter)
    ├── primary_button.dart            # Ekspor komponen tombol utama
    ├── progress_bar.dart              # Indikator progres menit pertandingan
    ├── question_card.dart             # Kartu penampil nomor & teks pertanyaan kuis
    ├── score_card.dart                # Kartu ringkasan skor akhir & bar akurasi
    ├── theme_toggle.dart              # Tombol pengubah mode Terang/Gelap di AppBar
    └── timer_widget.dart              # Indikator hitung mundur waktu (20 detik)

assets/
├── fonts/                             # Font kustom Oswald & Poppins
├── images/                            # Aset gambar aplikasi (ball.png)
└── icons/                             # Aset ikon tambahan (trophy.png)