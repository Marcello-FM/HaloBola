import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/pitch_background.dart';
import '../widgets/theme_toggle.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final board = [...quiz.leaderboard]
      ..sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Klasemen'),
        actions: const [ThemeToggleButton()],
      ),
      body: PitchBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
              child: board.isEmpty
                  ? _EmptyState(r: r, isDark: isDark)
                  : _LeagueTable(board: board, r: r, isDark: isDark),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Responsive r;
  final bool isDark;

  const _EmptyState({required this.r, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.leaderboard_outlined,
            size: r.sp(64),
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
          SizedBox(height: r.sp(16)),
          Text(
            AppStrings.leaderboardEmpty,
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: r.sp(22),
              letterSpacing: 0.5,
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
            ),
          ),
          SizedBox(height: r.sp(8)),
          Text(
            AppStrings.leaderboardEmptySub,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.sp(13),
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LeagueTable extends StatelessWidget {
  final List<dynamic> board;
  final Responsive r;
  final bool isDark;

  const _LeagueTable({
    required this.board,
    required this.r,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TableHeader(r: r, isDark: isDark),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: r.wp(4), vertical: r.sp(6)),
            itemCount: board.length,
            itemBuilder: (context, i) => _TableRow(
              entry: board[i],
              position: i + 1,
              r: r,
              isDark: isDark,
            ),
          ),
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final Responsive r;
  final bool isDark;

  const _TableHeader({required this.r, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.wp(4), vertical: r.sp(8)),
      padding: EdgeInsets.symmetric(horizontal: r.sp(14), vertical: r.sp(10)),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          SizedBox(width: r.sp(36)),
          Expanded(
            child: Text(
              'PEMAIN',
              style: _headerStyle(r),
            ),
          ),
          SizedBox(
            width: r.sp(60),
            child: Text(
              'SKOR',
              textAlign: TextAlign.center,
              style: _headerStyle(r),
            ),
          ),
          SizedBox(
            width: r.sp(50),
            child: Text(
              '%',
              textAlign: TextAlign.center,
              style: _headerStyle(r),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle(Responsive r) => TextStyle(
    fontFamily: 'Oswald',
    fontSize: r.sp(11),
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
  );
}

class _TableRow extends StatelessWidget {
  final dynamic entry;
  final int position;
  final Responsive r;
  final bool isDark;

  const _TableRow({
    required this.entry,
    required this.position,
    required this.r,
    required this.isDark,
  });

  static const Map<int, Color> _podiumColors = {
    1: AppColors.accentYellow,
    2: Color(0xFFC0C0C0),
    3: Color(0xFFCD7F32),
  };

  @override
  Widget build(BuildContext context) {
    final rankColor = _podiumColors[position];
    final isTop3 = position <= 3;
    final pct = entry.totalQuestions == 0
        ? 0.0
        : entry.score / entry.totalQuestions;

    return Container(
      margin: EdgeInsets.only(bottom: r.sp(6)),
      decoration: BoxDecoration(
        color: isTop3
            ? (rankColor ?? AppColors.accent).withValues(alpha: 0.07)
            : (isDark ? AppColors.darkCard : AppColors.lightCard),
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(
          color: isTop3
              ? (rankColor ?? AppColors.accent).withValues(alpha: 0.3)
              : (isDark
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.primary.withValues(alpha: 0.08)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: r.sp(14), vertical: r.sp(12)),
        child: Row(
          children: [
            SizedBox(
              width: r.sp(36),
              child: isTop3
                  ? Icon(
                Icons.emoji_events_rounded,
                color: rankColor,
                size: r.sp(22),
              )
                  : Center(
                child: Text(
                  '$position',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: r.sp(15),
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.playerName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.sp(14),
                      fontWeight: FontWeight.w600,
                      color:
                      isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Text(
                    '${entry.category} · ${entry.difficulty}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.sp(10),
                      color: isDark
                          ? AppColors.darkSubText
                          : AppColors.lightSubText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: r.sp(60),
              child: Text(
                '${entry.score}/${entry.totalQuestions}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: r.sp(16),
                  fontWeight: FontWeight.w700,
                  color: isTop3
                      ? (rankColor ?? AppColors.accent)
                      : AppColors.primary,
                ),
              ),
            ),
            SizedBox(
              width: r.sp(50),
              child: Text(
                '${(pct * 100).toInt()}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: r.sp(12),
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkSubText
                      : AppColors.lightSubText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}