import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/routes.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_review_item.dart';
import '../widgets/confetti_overlay.dart';
import '../widgets/hb_button.dart';
import '../widgets/pitch_background.dart';
import '../widgets/score_card.dart';
import '../widgets/theme_toggle.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _confettiTriggered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quiz = context.read<QuizProvider>();
      final pct = quiz.totalQuestions == 0
          ? 0.0
          : quiz.score / quiz.totalQuestions;
      if (pct >= 0.75 && mounted) {
        setState(() => _confettiTriggered = true);
      }
    });
  }

  void _goHome(QuizProvider quiz) {
    quiz.resetQuiz();
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.welcome, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pct =
    quiz.totalQuestions == 0 ? 0.0 : quiz.score / quiz.totalQuestions;
    final rank = AppStrings.getRankMessage(pct);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome(quiz);
      },
      child: ConfettiOverlay(
        trigger: _confettiTriggered,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hasil Pertandingan'),
            leading: IconButton(
              icon: const Icon(Icons.home_rounded),
              onPressed: () => _goHome(quiz),
            ),
            actions: const [ThemeToggleButton()],
          ),
          body: PitchBackground(
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints:
                  const BoxConstraints(maxWidth: AppConstants.maxWidth),
                  child: r.isWide
                      ? _WideResult(
                    quiz: quiz,
                    r: r,
                    isDark: isDark,
                    rank: rank,
                    pct: pct,
                    onHome: () => _goHome(quiz),
                  )
                      : _NarrowResult(
                    quiz: quiz,
                    r: r,
                    isDark: isDark,
                    rank: rank,
                    pct: pct,
                    onHome: () => _goHome(quiz),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NarrowResult extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;
  final bool isDark;
  final String rank;
  final double pct;
  final VoidCallback onHome;

  const _NarrowResult({
    required this.quiz,
    required this.r,
    required this.isDark,
    required this.rank,
    required this.pct,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
      EdgeInsets.symmetric(horizontal: r.wp(4.5), vertical: r.sp(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScoreCard(
            playerName: quiz.playerName,
            score: quiz.score,
            total: quiz.totalQuestions,
            rankMessage: rank,
          ),
          SizedBox(height: r.sp(16)),
          _InfoRow(quiz: quiz, r: r),
          SizedBox(height: r.sp(20)),
          _ActionButtons(
              quiz: quiz, r: r, context: context, onHome: onHome),
          SizedBox(height: r.sp(28)),
          _ReviewSection(quiz: quiz, r: r, isDark: isDark),
          SizedBox(height: r.sp(20)),
        ],
      ),
    );
  }
}

class _WideResult extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;
  final bool isDark;
  final String rank;
  final double pct;
  final VoidCallback onHome;

  const _WideResult({
    required this.quiz,
    required this.r,
    required this.isDark,
    required this.rank,
    required this.pct,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                r.wp(4), r.sp(16), r.wp(2), r.sp(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ScoreCard(
                  playerName: quiz.playerName,
                  score: quiz.score,
                  total: quiz.totalQuestions,
                  rankMessage: rank,
                ),
                SizedBox(height: r.sp(16)),
                _InfoRow(quiz: quiz, r: r),
                SizedBox(height: r.sp(20)),
                _ActionButtons(
                    quiz: quiz, r: r, context: context, onHome: onHome),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                r.wp(2), r.sp(16), r.wp(4), r.sp(16)),
            child: _ReviewSection(quiz: quiz, r: r, isDark: isDark),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;

  const _InfoRow({required this.quiz, required this.r});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: r.sp(8),
      runSpacing: r.sp(8),
      children: [
        _Chip(
          icon: Icons.category_outlined,
          label: quiz.category,
          color: AppColors.primary,
          r: r,
        ),
        _Chip(
          icon: Icons.signal_cellular_alt_rounded,
          label: quiz.difficulty,
          color: AppColors.accent,
          r: r,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;
  final BuildContext context;
  final VoidCallback onHome;

  const _ActionButtons({
    required this.quiz,
    required this.r,
    required this.context,
    required this.onHome,
  });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        HbButton(
          label: AppStrings.resultPlayAgain,
          icon: Icons.replay_rounded,
          onPressed: () {
            quiz.resetQuiz();
            Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.category,
                    (route) => route.settings.name == AppRoutes.welcome);
          },
          widthFactor: 1.0,
        ),
        SizedBox(height: r.sp(10)),
        HbButton(
          label: AppStrings.resultMenu,
          icon: Icons.home_rounded,
          backgroundColor: AppColors.primaryDark,
          onPressed: onHome,
          widthFactor: 1.0,
        ),
        SizedBox(height: r.sp(6)),
        TextButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.leaderboard),
          icon: Icon(Icons.leaderboard_rounded,
              color: AppColors.primary, size: r.sp(15)),
          label: Text(
            AppStrings.resultLeaderboard,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.sp(13),
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewSection extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;
  final bool isDark;

  const _ReviewSection({
    required this.quiz,
    required this.r,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: r.sp(4),
              height: r.sp(22),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: r.sp(10)),
            Text(
              AppStrings.resultReviewTitle.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: r.sp(16),
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: r.sp(12)),
        ...quiz.answerRecords.asMap().entries.map(
              (e) => AnswerReviewItem(record: e.value, index: e.key),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Responsive r;

  const _Chip({
    required this.icon,
    required this.label,
    required this.color,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(6)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: r.sp(14)),
          SizedBox(width: r.sp(5)),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: r.sp(12),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}