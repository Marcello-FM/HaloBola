import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Color accentColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.accentColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: AppShapes.categoryCard,
          border: Border.all(
            color: isSelected
                ? accentColor
                : accentColor.withValues(alpha:  0.25),
            width: isSelected ? 0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? accentColor.withValues(alpha:  0.35)
                  : Colors.black.withValues(alpha:  0.05),
              blurRadius: isSelected ? 14 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                right: -r.sp(10),
                bottom: -r.sp(10),
                child: Opacity(
                  opacity: 0.15,
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: r.sp(64)),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: r.sp(10), vertical: r.sp(14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emoji,
                    style: TextStyle(fontSize: r.sp(28)),
                  ),
                  SizedBox(height: r.sp(8)),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.sp(11),
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? AppColors.darkText : AppColors.lightText),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
