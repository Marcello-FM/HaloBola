import 'package:flutter/material.dart';
import '../screens/welcome_screen.dart';
import '../screens/category_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../screens/leaderboard_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String category = '/category';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String leaderboard = '/leaderboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return _fadeRoute(const WelcomeScreen(), settings);
      case category:
        return _slideRoute(const CategoryScreen(), settings);
      case quiz:
        return _slideRoute(const QuizScreen(), settings);
      case result:
        return _slideRoute(const ResultScreen(), settings);
      case leaderboard:
        return _slideRoute(const LeaderboardScreen(), settings);
      default:
        return _fadeRoute(const WelcomeScreen(), settings);
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, a1, a2) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, a1, a2) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
