import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF29B6F6);
  static const Color primaryDark = Color(0xFF0288D1);
  static const Color primaryDeep = Color(0xFF01579B);

  static const Color accent = Color(0xFFFF9800);
  static const Color accentDeep = Color(0xFFE65100);
  static const Color accentYellow = Color(0xFFFFD600);

  static const Color lightBackground = Color(0xFFEDF6FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardAlt = Color(0xFFF0F9FF);
  static const Color lightText = Color(0xFF0D1B2A);
  static const Color lightSubText = Color(0xFF546E7A);
  static const Color lightPitch = Color(0xFF1A5C2A);

  static const Color darkBackground = Color(0xFF060F1E);
  static const Color darkSurface = Color(0xFF0D1E33);
  static const Color darkCard = Color(0xFF122340);
  static const Color darkCardAlt = Color(0xFF0F1C30);
  static const Color darkText = Color(0xFFE8F4FD);
  static const Color darkSubText = Color(0xFF90CAF9);
  static const Color darkPitch = Color(0xFF0D2E14);

  static const Color correct = Color(0xFF2E7D32);
  static const Color correctLight = Color(0xFF4CAF50);
  static const Color wrong = Color(0xFFC62828);
  static const Color wrongLight = Color(0xFFEF5350);
  static const Color timeout = Color(0xFFF57F17);
  static const Color timeoutLight = Color(0xFFFFCA28);
  static const Color unanswered = Color(0xFF546E7A);

  static const Color timerSafe = Color(0xFF29B6F6);
  static const Color timerWarning = Color(0xFFFF9800);
  static const Color timerDanger = Color(0xFFD32F2F);

  static const Color pitchLineLight = Color(0x1429B6F6);
  static const Color pitchLineDark = Color(0x1A29B6F6);

  static Color pitchLine(bool isDark) =>
      isDark ? pitchLineDark : pitchLineLight;
}

class AppShapes {
  static const double radiusSm = 8;
  static const double radiusMd = 14;
  static const double radiusLg = 20;
  static const double radiusXl = 28;
  static const double diagonalCut = 18;

  static BorderRadius get card => BorderRadius.circular(radiusMd);
  static BorderRadius get button => BorderRadius.circular(radiusMd);
  static BorderRadius get pill => BorderRadius.circular(100);
  static BorderRadius get categoryCard =>
      const BorderRadius.only(
        topLeft: Radius.circular(radiusLg),
        topRight: Radius.circular(radiusSm),
        bottomLeft: Radius.circular(radiusSm),
        bottomRight: Radius.circular(radiusLg),
      );
}

class AppTheme {
  static ThemeData light() {
    return _build(
      brightness: Brightness.light,
      bg: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      card: AppColors.lightCard,
      text: AppColors.lightText,
    );
  }

  static ThemeData dark() {
    return _build(
      brightness: Brightness.dark,
      bg: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      card: AppColors.darkCard,
      text: AppColors.darkText,
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color card,
    required Color text,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: surface,
      ),
      scaffoldBackgroundColor: bg,
      fontFamily: 'Poppins',
      textTheme: _buildTextTheme(text),
      appBarTheme: AppBarTheme(
        backgroundColor: brightness == Brightness.dark
            ? AppColors.darkSurface
            : AppColors.primary,
        foregroundColor: brightness == Brightness.dark
            ? AppColors.darkText
            : Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Oswald',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: brightness == Brightness.dark ? AppColors.darkText : Colors.white,
          letterSpacing: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppShapes.card),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppShapes.button),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusMd),
          borderSide: BorderSide(color: AppColors.primary.withValues(alpha:  0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppShapes.radiusMd),
          borderSide: BorderSide(color: AppColors.primary.withValues(alpha:  0.25)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.primary.withValues(alpha:  0.1),
        thickness: 1,
      ),
    );
  }

  static TextTheme _buildTextTheme(Color base) {
    return TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Oswald', color: base, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(
          fontFamily: 'Oswald', color: base, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(
          fontFamily: 'Oswald',
          color: base,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
      headlineMedium: TextStyle(
          fontFamily: 'Oswald', color: base, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontFamily: 'Oswald', color: base, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontFamily: 'Poppins', color: base, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
          fontFamily: 'Poppins', color: base, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(
          fontFamily: 'Poppins', color: base, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: 'Poppins', color: base),
      bodyMedium: TextStyle(fontFamily: 'Poppins', color: base),
      bodySmall:
          TextStyle(fontFamily: 'Poppins', color: base, fontSize: 12),
      labelLarge: TextStyle(
          fontFamily: 'Poppins', color: base, fontWeight: FontWeight.w600),
    );
  }
}
