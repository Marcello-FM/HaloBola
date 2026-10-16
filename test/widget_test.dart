import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:halabola/providers/quiz_provider.dart';
import 'package:halabola/providers/theme_provider.dart';
import 'package:halabola/core/routes.dart';
import 'package:halabola/core/theme.dart';

void main() {
  testWidgets('HalaBola app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: Builder(
          builder: (context) {
            final themeProvider = context.watch<ThemeProvider>();
            return MaterialApp(
              title: 'HalaBola',
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeProvider.themeMode,
              initialRoute: AppRoutes.welcome,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  });
}
