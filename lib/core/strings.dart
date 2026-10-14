class AppStrings {
  static const String appName = 'HalaBola';
  static const String appTagline = 'Seberapa jauh kamu\nmengenal sepak bola?';

  static const String welcomeNameLabel = 'Nama Pemain';
  static const String welcomeNameHint = 'Siapa nama pemainmu?';
  static const String welcomeNameError = 'Nama tidak boleh kosong';
  static const String welcomeNameErrorShort = 'Nama minimal 2 karakter';
  static const String welcomeStartButton = 'Peluit Mulai!';
  static const String welcomeLeaderboard = 'Papan Klasemen';

  static const String categoryTitle = 'Pilih Lapangan Pertandingan';
  static const String categorySubtitle = 'Tentukan area permainanmu.';
  static const String categoryDifficulty = 'Level Pertandingan';
  static const String categoryStart = 'Tendang Bola!';
  static const String categoryNoQuestions = 'Tidak ada soal untuk kombinasi ini. Coba pilihan lain.';

  static const String quizExitTitle = 'Tinggalkan Pertandingan?';
  static const String quizExitBody = 'Progres kamu akan hilang. Yakin ingin keluar?';
  static const String quizExitCancel = 'Lanjutkan';
  static const String quizExitConfirm = 'Keluar';
  static const String quizNextButton = 'Serangan Berikutnya';
  static const String quizLastButton = 'Peluit Akhir';
  static const String quizLoading = 'Menyiapkan pertandingan...';

  static const String answerCorrect = 'GOL!';
  static const String answerWrong = 'Offside!';
  static const String answerTimeout = 'Waktu Habis, Kartu Kuning!';

  static const String resultTitle = 'Papan Skor';
  static const String resultPlayAgain = 'Main Lagi';
  static const String resultMenu = 'Menu Utama';
  static const String resultLeaderboard = 'Lihat Klasemen';
  static const String resultReviewTitle = 'Review Pertandingan';
  static const String resultCorrectLabel = 'Benar';
  static const String resultWrongLabel = 'Salah';
  static const String resultTimeoutLabel = 'Waktu Habis';
  static const String resultYourAnswer = 'Jawaban kamu:';
  static const String resultCorrectAnswer = 'Jawaban benar:';

  static const String leaderboardTitle = 'Klasemen';
  static const String leaderboardEmpty = 'Belum Ada Skor';
  static const String leaderboardEmptySub = 'Selesaikan kuis untuk\nmuncul di sini!';

  static const String difficultyEasy = 'Mudah';
  static const String difficultyMedium = 'Sedang';
  static const String difficultyHard = 'Sulit';

  static const String minuteLabel = 'Menit';

  static String getRankMessage(double percentage) {
    if (percentage >= 0.9) return "Ballon d'Or!";
    if (percentage >= 0.75) return 'Pemain Inti';
    if (percentage >= 0.6) return 'Pemain Profesional';
    if (percentage >= 0.4) return 'Pemain Cadangan';
    return 'Perlu Latihan Lagi';
  }

  static String getRankEmoji(double percentage) {
    if (percentage >= 0.9) return '🏅';
    if (percentage >= 0.75) return '⭐';
    if (percentage >= 0.6) return '👏';
    if (percentage >= 0.4) return '🌱';
    return '📋';
  }
}
