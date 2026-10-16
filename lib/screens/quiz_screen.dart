import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/routes.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_option_button.dart';
import '../widgets/hb_button.dart';
import '../widgets/pitch_background.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/timer_widget.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _showExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<QuizProvider>(
            builder: (context, q, _) => Text(q.category),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _showExit(context),
          ),
          actions: const [ThemeToggleButton()],
        ),
        body: Consumer<QuizProvider>(
          builder: (context, quiz, _) {
            if (quiz.currentQuestion == null) {
              return Center(
                child: Text(
                  AppStrings.quizLoading,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: Responsive(context).sp(14)),
                ),
              );
            }
            if (quiz.status == QuizStatus.finished) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, AppRoutes.result);
              });
              return const Center(child: CircularProgressIndicator());
            }
            return _QuizBody(quiz: quiz);
          },
        ),
      ),
    );
  }

  void _showExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppShapes.radiusXl)),
        title: Text(AppStrings.quizExitTitle,
            style: const TextStyle(
                fontFamily: 'Oswald', fontWeight: FontWeight.w700)),
        content: Text(AppStrings.quizExitBody,
            style: const TextStyle(fontFamily: 'Poppins')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppStrings.quizExitCancel,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: AppColors.primary)),
          ),
          ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: AppColors.wrong),
            onPressed: () {
              context.read<QuizProvider>().resetQuiz();
              Navigator.pop(ctx);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.welcome, (_) => false);
            },
            child: Text(AppStrings.quizExitConfirm,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _QuizBody extends StatelessWidget {
  final QuizProvider quiz;

  const _QuizBody({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    if (r.isWide && r.isLandscape) {
      return _WideLayout(quiz: quiz);
    }
    return _NarrowLayout(quiz: quiz);
  }
}

class _NarrowLayout extends StatelessWidget {
  final QuizProvider quiz;

  const _NarrowLayout({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final q = quiz.currentQuestion!;

    return PitchBackground(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: r.wp(4.5), vertical: r.sp(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizProgressBar(
                      current: quiz.currentIndex,
                      total: quiz.totalQuestions),
                  SizedBox(height: r.sp(14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DiffBadge(difficulty: quiz.difficulty, r: r),
                      TimerWidget(seconds: quiz.timerSeconds),
                    ],
                  ),
                  SizedBox(height: r.sp(12)),
                  QuestionCard(
                    questionText: q.questionText,
                    currentIndex: quiz.currentIndex,
                    totalQuestions: quiz.totalQuestions,
                  ),
                  SizedBox(height: r.sp(10)),
                  ...q.options.map((opt) => AnswerOptionButton(
                    optionText: opt,
                    correctAnswer: q.correctAnswer,
                    selectedAnswer: quiz.selectedAnswer,
                    status: quiz.status,
                    onTap: () =>
                        context.read<QuizProvider>().submitAnswer(opt),
                  )),
                  if (quiz.status == QuizStatus.answered) ...[
                    SizedBox(height: r.sp(12)),
                    _StatusBanner(quiz: quiz, r: r),
                    SizedBox(height: r.sp(8)),
                    _ExplainCard(text: q.explanation, r: r),
                    SizedBox(height: r.sp(14)),
                    Center(
                      child: HbButton(
                        label: quiz.isLastQuestion
                            ? AppStrings.quizLastButton
                            : AppStrings.quizNextButton,
                        icon: quiz.isLastQuestion
                            ? Icons.emoji_events_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: () =>
                            context.read<QuizProvider>().nextQuestion(),
                      ),
                    ),
                  ],
                  SizedBox(height: r.sp(16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  final QuizProvider quiz;

  const _WideLayout({required this.quiz});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final q = quiz.currentQuestion!;

    return PitchBackground(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: r.wp(4), vertical: r.sp(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          QuizProgressBar(
                              current: quiz.currentIndex,
                              total: quiz.totalQuestions),
                          SizedBox(height: r.sp(14)),
                          Row(
                            children: [
                              _DiffBadge(difficulty: quiz.difficulty, r: r),
                              const Spacer(),
                              TimerWidget(seconds: quiz.timerSeconds),
                            ],
                          ),
                          SizedBox(height: r.sp(12)),
                          QuestionCard(
                            questionText: q.questionText,
                            currentIndex: quiz.currentIndex,
                            totalQuestions: quiz.totalQuestions,
                          ),
                          if (quiz.status == QuizStatus.answered) ...[
                            SizedBox(height: r.sp(12)),
                            _StatusBanner(quiz: quiz, r: r),
                            SizedBox(height: r.sp(8)),
                            _ExplainCard(text: q.explanation, r: r),
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: r.wp(3)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...q.options.map((opt) => AnswerOptionButton(
                            optionText: opt,
                            correctAnswer: q.correctAnswer,
                            selectedAnswer: quiz.selectedAnswer,
                            status: quiz.status,
                            onTap: () => context
                                .read<QuizProvider>()
                                .submitAnswer(opt),
                          )),
                          if (quiz.status == QuizStatus.answered) ...[
                            SizedBox(height: r.sp(12)),
                            HbButton(
                              label: quiz.isLastQuestion
                                  ? AppStrings.quizLastButton
                                  : AppStrings.quizNextButton,
                              icon: quiz.isLastQuestion
                                  ? Icons.emoji_events_rounded
                                  : Icons.arrow_forward_rounded,
                              onPressed: () =>
                                  context.read<QuizProvider>().nextQuestion(),
                              widthFactor: 1.0,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiffBadge extends StatelessWidget {
  final String difficulty;
  final Responsive r;

  const _DiffBadge({required this.difficulty, required this.r});

  Color get _color {
    switch (difficulty) {
      case AppConstants.difficultyEasy:
        return AppColors.correctLight;
      case AppConstants.difficultyMedium:
        return AppColors.accent;
      default:
        return AppColors.wrongLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(10), vertical: r.sp(4)),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        difficulty.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Oswald',
          fontSize: r.sp(11),
          fontWeight: FontWeight.w700,
          color: _color,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final QuizProvider quiz;
  final Responsive r;

  const _StatusBanner({required this.quiz, required this.r});

  @override
  Widget build(BuildContext context) {
    final lastRecord =
    quiz.answerRecords.isNotEmpty ? quiz.answerRecords.last : null;
    if (lastRecord == null) return const SizedBox.shrink();

    final Color color;
    final IconData icon;
    final String text;

    if (lastRecord.isTimeout) {
      color = AppColors.timeout;
      icon = Icons.timer_off_rounded;
      text = AppStrings.answerTimeout;
    } else if (lastRecord.isCorrect) {
      color = AppColors.correctLight;
      icon = Icons.sports_soccer;
      text = AppStrings.answerCorrect;
    } else {
      color = AppColors.wrongLight;
      icon = Icons.flag_rounded;
      text = AppStrings.answerWrong;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(14), vertical: r.sp(10)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: r.sp(20)),
          SizedBox(width: r.sp(10)),
          Expanded(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: r.sp(15),
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplainCard extends StatelessWidget {
  final String text;
  final Responsive r;

  const _ExplainCard({required this.text, required this.r});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(r.sp(14)),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded,
              color: AppColors.accentYellow, size: r.sp(16)),
          SizedBox(width: r.sp(10)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(12),
                color: isDark ? AppColors.darkText : AppColors.lightText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}