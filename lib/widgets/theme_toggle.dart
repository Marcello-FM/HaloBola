import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final r = Responsive(context);

    return IconButton(
      tooltip: tp.isDarkMode ? 'Mode Terang' : 'Mode Gelap',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: FadeTransition(opacity: anim, child: child)),
        child: Icon(
          tp.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          key: ValueKey(tp.isDarkMode),
          color: tp.isDarkMode
              ? AppColors.accentYellow
              : AppColors.lightText,
          size: r.sp(22),
        ),
      ),
      onPressed: () => tp.toggleTheme(),
    );
  }
}