import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/strings.dart';
import '../core/theme.dart';

class ScoreCard extends StatelessWidget {
  final String playerName;
  final int score;
  final int total;
  final String rankMessage;

  const ScoreCard({
    super.key,
    required this.playerName,
    required this.score,
    required this.total,
    required this.rankMessage,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final wrong = total - score;
    final pct = total == 0 ? 0.0 : score / total;
    final emoji = AppStrings.getRankEmoji(pct);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppShapes.radiusXl),
        border: Border.all(
          color: AppColors.primary.withValues(alpha:  0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha:  0.1),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppShapes.radiusXl),
              topRight: Radius.circular(AppShapes.radiusXl),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(r.sp(20)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.darkSurface, AppColors.darkBackground]
                      : [AppColors.primary.withValues(alpha:  0.08), AppColors.lightBackground],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        emoji,
                        style: TextStyle(fontSize: r.sp(22)),
                      ),
                      SizedBox(width: r.sp(8)),
                      Expanded(
                        child: Text(
                          rankMessage,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: r.sp(18),
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.sp(4)),
                  Text(
                    playerName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.sp(13),
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r.sp(20)),
            child: Row(
              children: [
                Expanded(child: _ScoreBox(label: 'SKOR', value: '$score/$total', color: AppColors.primary, r: r)),
                SizedBox(width: r.sp(10)),
                Expanded(child: _ScoreBox(label: 'BENAR', value: '$score', color: AppColors.correctLight, r: r)),
                SizedBox(width: r.sp(10)),
                Expanded(child: _ScoreBox(label: 'SALAH', value: '$wrong', color: AppColors.wrongLight, r: r)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: r.sp(20), right: r.sp(20), bottom: r.sp(20)),
            child: _buildPctBar(r, pct, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPctBar(Responsive r, double pct, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Akurasi',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(11),
                color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
              ),
            ),
            Text(
              '${(pct * 100).toInt()}%',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: r.sp(13),
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(6)),
        Stack(
          children: [
            Container(
              height: r.sp(6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardAlt : AppColors.lightCardAlt,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: pct.clamp(0.0, 1.0),
              child: Container(
                height: r.sp(6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.accent, AppColors.accentYellow]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScoreBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Responsive r;

  const _ScoreBox({
    required this.label,
    required this.value,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: r.sp(12)),
      decoration: BoxDecoration(
        color: color.withValues(alpha:  0.08),
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(color: color.withValues(alpha:  0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: r.sp(22),
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.sp(9),
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
