import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../core/responsive.dart';
import '../core/routes.dart';
import '../core/strings.dart';
import '../core/theme.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/hb_button.dart';
import '../widgets/pitch_background.dart';
import '../widgets/theme_toggle.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onStart() {
    if (_formKey.currentState!.validate()) {
      context.read<QuizProvider>().setPlayerName(_ctrl.text.trim());
      Navigator.pushNamed(context, AppRoutes.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PitchBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: AppConstants.maxWidth),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    floating: true,
                    actions: const [ThemeToggleButton()],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.wp(6),
                        vertical: r.sp(12),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLogo(animate: true),
                            SizedBox(height: r.sp(28)),
                            Text(
                              AppStrings.appTagline,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.sp(15),
                                color: isDark
                                    ? AppColors.darkSubText
                                    : AppColors.lightSubText,
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: r.sp(32)),
                            _InputLabel(label: AppStrings.welcomeNameLabel, r: r, isDark: isDark),
                            SizedBox(height: r.sp(8)),
                            TextFormField(
                              controller: _ctrl,
                              decoration: InputDecoration(
                                hintText: AppStrings.welcomeNameHint,
                                prefixIcon: const Icon(
                                    Icons.person_outline_rounded,
                                    color: AppColors.primary),
                                hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.sp(14),
                                    color: isDark
                                        ? AppColors.darkSubText
                                        : AppColors.lightSubText),
                              ),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: r.sp(14),
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                              ),
                              textCapitalization: TextCapitalization.words,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return AppStrings.welcomeNameError;
                                }
                                if (v.trim().length < 2) {
                                  return AppStrings.welcomeNameErrorShort;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: r.sp(28)),
                            Center(
                              child: HbButton(
                                label: AppStrings.welcomeStartButton,
                                icon: Icons.sports_soccer,
                                onPressed: _onStart,
                              ),
                            ),
                            SizedBox(height: r.sp(12)),
                            Center(
                              child: TextButton.icon(
                                onPressed: () => Navigator.pushNamed(
                                    context, AppRoutes.leaderboard),
                                icon: Icon(Icons.leaderboard_rounded,
                                    color: AppColors.primary,
                                    size: r.sp(16)),
                                label: Text(
                                  AppStrings.welcomeLeaderboard,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: r.sp(13),
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            _FooterIcons(r: r),
                            SizedBox(height: r.sp(8)),
                          ],
                        ),
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

class _InputLabel extends StatelessWidget {
  final String label;
  final Responsive r;
  final bool isDark;

  const _InputLabel(
      {required this.label, required this.r, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Oswald',
        fontSize: r.sp(12),
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
      ),
    );
  }
}

class _FooterIcons extends StatelessWidget {
  final Responsive r;

  const _FooterIcons({required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.sports_soccer,
            color: AppColors.primary.withValues(alpha:  0.2), size: r.sp(20)),
        SizedBox(width: r.sp(10)),
        Icon(Icons.emoji_events_outlined,
            color: AppColors.accent.withValues(alpha:  0.2), size: r.sp(20)),
        SizedBox(width: r.sp(10)),
        Icon(Icons.sports_score_outlined,
            color: AppColors.primary.withValues(alpha:  0.2), size: r.sp(20)),
      ],
    );
  }
}
