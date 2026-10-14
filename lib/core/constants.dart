class AppConstants {
  static const String appName = 'HalaBola';
  static const int timerSeconds = 20;
  static const double maxWidth = 800;

  static const String categoryWorld = 'Sejarah Piala Dunia';
  static const String categoryIndonesia = 'Timnas Indonesia';
  static const String categoryRules = 'Aturan & Istilah Sepak Bola';
  static const String categoryLegends = 'Legenda & Rekor';

  static const String difficultyEasy = 'Mudah';
  static const String difficultyMedium = 'Sedang';
  static const String difficultyHard = 'Sulit';

  static const List<String> categories = [
    categoryWorld,
    categoryIndonesia,
    categoryRules,
    categoryLegends,
  ];

  static const List<String> difficulties = [
    difficultyEasy,
    difficultyMedium,
    difficultyHard,
  ];

  static const Map<String, String> categoryIcons = {
    categoryWorld: 'trophy',
    categoryIndonesia: 'eagle',
    categoryRules: 'whistle',
    categoryLegends: 'star',
  };

  static const Map<String, String> categoryEmoji = {
    categoryWorld: '🏆',
    categoryIndonesia: '🦅',
    categoryRules: '📖',
    categoryLegends: '⭐',
  };
}
