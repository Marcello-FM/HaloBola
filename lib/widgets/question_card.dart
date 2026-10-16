import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final int currentIndex;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppShapes.radiusLg),
          topRight: const Radius.circular(AppShapes.radiusSm),
          bottomLeft: const Radius.circular(AppShapes.radiusSm),
          bottomRight: const Radius.circular(AppShapes.radiusLg),
        ),
        border: Border.all(
          color: AppColors.primary.withValues(alpha:  0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha:  0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: r.sp(16), vertical: r.sp(9)),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:  0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppShapes.radiusLg),
                topRight: Radius.circular(AppShapes.radiusSm),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: r.sp(6),
                  height: r.sp(6),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: r.sp(8)),
                Text(
                  'Soal ${currentIndex + 1} dari $totalQuestions',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.sp(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r.sp(16)),
            child: Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(15),
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
