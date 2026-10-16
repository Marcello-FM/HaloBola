import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/routes.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../data/questions_data.dart';
import '../providers/quiz_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/hb_button.dart';
import '../widgets/theme_toggle.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _cat = AppConstants.categories[0];
  String _diff = AppConstants.difficultyMedium;

  static const List<Color> _categoryColors = [
    AppColors.accent,
    AppColors.correctLight,
    AppColors.primary,
    AppColors.accentYellow,
  ];

  int get _questionCount => getQuestions(_cat, _diff).length;

  void _start() {
    if (_questionCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.categoryNoQuestions,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: Responsive(context).sp(13)),
          ),
          backgroundColor: AppColors.wrong,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }
    context.read<QuizProvider>().startQuiz(_cat, _diff);
    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HalaBola'),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: r.wp(5),
                vertical: r.sp(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.categoryTitle,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: r.sp(26),
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: r.sp(4)),
                  Text(
                    AppStrings.categorySubtitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: r.sp(13),
                      color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
                    ),
                  ),
                  SizedBox(height: r.sp(20)),
                  LayoutBuilder(
                    builder: (ctx, box) {
                      final cols = box.maxWidth > 480 ? 4 : 2;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          mainAxisSpacing: r.sp(10),
                          crossAxisSpacing: r.sp(10),
                          childAspectRatio: 0.9,
                        ),
                        itemCount: AppConstants.categories.length,
                        itemBuilder: (ctx, i) {
                          final cat = AppConstants.categories[i];
                          return CategoryCard(
                            title: cat,
                            emoji: AppConstants.categoryEmoji[cat] ?? '⚽',
                            accentColor: _categoryColors[i],
                            isSelected: _cat == cat,
                            onTap: () => setState(() => _cat = cat),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: r.sp(28)),
                  _SectionLabel(
                      label: AppStrings.categoryDifficulty, r: r, isDark: isDark),
                  SizedBox(height: r.sp(10)),
                  _DifficultyRow(
                    selected: _diff,
                    onSelect: (d) => setState(() => _diff = d),
                    r: r,
                    isDark: isDark,
                  ),
                  SizedBox(height: r.sp(16)),
                  _QuestionCountBadge(
                      count: _questionCount,
                      category: _cat,
                      difficulty: _diff,
                      r: r),
                  SizedBox(height: r.sp(28)),
                  Center(
                    child: HbButton(
                      label: AppStrings.categoryStart,
                      icon: Icons.sports_soccer,
                      onPressed: _start,
                    ),
                  ),
                  SizedBox(height: r.sp(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final Responsive r;
  final bool isDark;

  const _SectionLabel(
      {required this.label, required this.r, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Oswald',
        fontSize: r.sp(13),
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
        color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
      ),
    );
  }
}

class _DifficultyRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  final Responsive r;
  final bool isDark;

  static const Map<String, Color> _diffColors = {
    AppConstants.difficultyEasy: AppColors.correctLight,
    AppConstants.difficultyMedium: AppColors.accent,
    AppConstants.difficultyHard: AppColors.wrongLight,
  };

  const _DifficultyRow({
    required this.selected,
    required this.onSelect,
    required this.r,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AppConstants.difficulties.map((d) {
        final isSelected = selected == d;
        final color = _diffColors[d] ?? AppColors.primary;

        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(d),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: r.sp(3)),
              padding: EdgeInsets.symmetric(vertical: r.sp(11)),
              decoration: BoxDecoration(
                color: isSelected
                    ? color
                    : (isDark ? AppColors.darkCard : AppColors.lightCard),
                borderRadius: BorderRadius.circular(AppShapes.radiusMd),
                border: Border.all(
                  color: isSelected ? color : color.withValues(alpha: 0.3),
                  width: isSelected ? 0 : 1.5,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
                    : [],
              ),
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: r.sp(13),
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuestionCountBadge extends StatelessWidget {
  final int count;
  final String category;
  final String difficulty;
  final Responsive r;

  const _QuestionCountBadge({
    required this.count,
    required this.category,
    required this.difficulty,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final ok = count > 0;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: r.sp(14), vertical: r.sp(10)),
      decoration: BoxDecoration(
        color: ok
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.wrong.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppShapes.radiusMd),
        border: Border.all(
            color: ok
                ? AppColors.primary.withValues(alpha: 0.2)
                : AppColors.wrong.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            ok ? Icons.sports_soccer : Icons.warning_amber_rounded,
            color: ok ? AppColors.primary : AppColors.wrongLight,
            size: r.sp(16),
          ),
          SizedBox(width: r.sp(8)),
          Expanded(
            child: Text(
              ok
                  ? '$count soal tersedia — "$category" ($difficulty)'
                  : AppStrings.categoryNoQuestions,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: r.sp(12),
                color: ok ? AppColors.primary : AppColors.wrongLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}