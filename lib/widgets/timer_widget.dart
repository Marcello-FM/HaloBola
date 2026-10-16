import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

class TimerWidget extends StatelessWidget {
  final int seconds;

  const TimerWidget({super.key, required this.seconds});

  Color _color() {
    if (seconds > 10) return AppColors.timerSafe;
    if (seconds > 5) return AppColors.timerWarning;
    return AppColors.timerDanger;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final progress = seconds / AppConstants.timerSeconds;
    final color = _color();
    final size = r.sp(54);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              border: Border.all(
                  color: color.withValues(alpha:  0.2), width: r.sp(3)),
            ),
          ),
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: r.sp(3.5),
              backgroundColor: color.withValues(alpha:  0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$seconds',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: r.sp(16),
                  fontWeight: FontWeight.w700,
                  color: color,
                  height: 1,
                ),
              ),
              Text(
                'det',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.sp(7),
                  color: color.withValues(alpha:  0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
