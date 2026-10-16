import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../models/quiz_result.dart';

class AnswerReviewItem extends StatelessWidget {
  final AnswerRecord record;
  final int index;

  const AnswerReviewItem({
    super.key,
    required this.record,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color accentColor;
    IconData statusIcon;
    String statusLabel;

    if (record.isTimeout) {
      accentColor = AppColors.timeout;
      statusIcon = Icons.timer_off_rounded;
      statusLabel = AppStrings.resultTimeoutLabel;
    } else if (record.isCorrect) {
      accentColor = AppColors.correctLight;
      statusIcon = Icons.check_circle_rounded;
      statusLabel = AppStrings.resultCorrectLabel;
    } else {
      accentColor = AppColors.wrongLight;
      statusIcon = Icons.cancel_rounded;
      statusLabel = AppStrings.resultWrongLabel;
    }

    return Container(
      margin: EdgeInsets.only(bottom: r.sp(8)),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border(
          left: BorderSide(color: accentColor, width: r.sp(4)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(r.sp(14), r.sp(12), r.sp(14), r.sp(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: r.sp(22),
                  height: r.sp(22),
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: r.sp(10),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: r.sp(8)),
                Icon(statusIcon, color: accentColor, size: r.sp(16)),
                SizedBox(width: r.sp(4)),
                Text(
                  statusLabel,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.sp(11),
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: r.sp(8)),
            Text(
              record.questionText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(13),
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                height: 1.45,
              ),
            ),
            SizedBox(height: r.sp(8)),
            if (!record.isTimeout && !record.isCorrect)
              _Row(
                  label: AppStrings.resultYourAnswer,
                  value: record.chosenAnswer ?? '-',
                  color: AppColors.wrongLight,
                  r: r),
            _Row(
                label: AppStrings.resultCorrectAnswer,
                value: record.correctAnswer,
                color: AppColors.correctLight,
                r: r),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Responsive r;

  const _Row({
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(top: r.sp(2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.sp(11),
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
            ),
          ),
          SizedBox(width: r.sp(6)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(11),
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
