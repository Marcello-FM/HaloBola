import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';
import '../providers/quiz_provider.dart';

class AnswerOptionButton extends StatefulWidget {
  final String optionText;
  final String correctAnswer;
  final String? selectedAnswer;
  final QuizStatus status;
  final VoidCallback? onTap;

  const AnswerOptionButton({
    super.key,
    required this.optionText,
    required this.correctAnswer,
    required this.selectedAnswer,
    required this.status,
    required this.onTap,
  });

  @override
  State<AnswerOptionButton> createState() => _AnswerOptionButtonState();
}

class _AnswerOptionButtonState extends State<AnswerOptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _shake;
  late Animation<double> _pop;

  _AnswerState _resolveState() {
    if (widget.status != QuizStatus.answered) return _AnswerState.normal;
    if (widget.status == QuizStatus.answered &&
        widget.selectedAnswer == null &&
        widget.optionText == widget.correctAnswer) {
      return _AnswerState.timeout;
    }
    if (widget.optionText == widget.correctAnswer) return _AnswerState.correct;
    if (widget.optionText == widget.selectedAnswer) return _AnswerState.wrong;
    return _AnswerState.normal;
  }

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _shake = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
    _pop = Tween(begin: 1.0, end: 1.06).animate(
        CurvedAnimation(parent: _anim, curve: Curves.elasticOut));
  }

  @override
  void didUpdateWidget(AnswerOptionButton old) {
    super.didUpdateWidget(old);
    if (old.status != QuizStatus.answered &&
        widget.status == QuizStatus.answered) {
      final state = _resolveState();
      if (state == _AnswerState.wrong) _anim.forward(from: 0);
      if (state == _AnswerState.correct) _anim.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = _resolveState();
    final isLocked = widget.status == QuizStatus.answered;

    Color bg, borderColor, textColor;
    IconData? stateIcon;
    Color? accentStripe;

    switch (state) {
      case _AnswerState.correct:
        bg = AppColors.correct;
        borderColor = AppColors.correct;
        textColor = Colors.white;
        stateIcon = Icons.check_circle_rounded;
        accentStripe = AppColors.correctLight;
      case _AnswerState.wrong:
        bg = AppColors.wrong;
        borderColor = AppColors.wrong;
        textColor = Colors.white;
        stateIcon = Icons.cancel_rounded;
        accentStripe = AppColors.wrongLight;
      case _AnswerState.timeout:
        bg = AppColors.timeout;
        borderColor = AppColors.timeout;
        textColor = Colors.white;
        stateIcon = Icons.timer_off_rounded;
        accentStripe = AppColors.timeoutLight;
      case _AnswerState.normal:
        bg = isDark ? AppColors.darkCard : AppColors.lightCard;
        borderColor = AppColors.primary.withValues(alpha:  0.25);
        textColor = isDark ? AppColors.darkText : AppColors.lightText;
        stateIcon = null;
        accentStripe = null;
    }

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      margin: EdgeInsets.symmetric(vertical: r.sp(3.5)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(r.cardBorderRadius),
        border: Border.all(color: borderColor, width: state == _AnswerState.normal ? 1.5 : 0),
        boxShadow: state != _AnswerState.normal
            ? [
                BoxShadow(
                    color: borderColor.withValues(alpha:  0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ]
            : [
                BoxShadow(
                    color: Colors.black.withValues(alpha:  0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(r.cardBorderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLocked ? null : widget.onTap,
            splashColor: AppColors.primary.withValues(alpha:  0.12),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: r.sp(14), vertical: r.sp(13)),
              child: Row(
                children: [
                  if (accentStripe != null) ...[
                    Container(
                      width: r.sp(4),
                      height: r.sp(24),
                      decoration: BoxDecoration(
                        color: accentStripe,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: r.sp(10)),
                  ] else ...[
                    SizedBox(width: r.sp(14)),
                  ],
                  Expanded(
                    child: Text(
                      widget.optionText,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: r.bodyFontSize,
                        fontWeight: state == _AnswerState.normal
                            ? FontWeight.w500
                            : FontWeight.w600,
                        color: textColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (stateIcon != null) ...[
                    SizedBox(width: r.sp(8)),
                    Icon(stateIcon, color: accentStripe, size: r.sp(20)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (state == _AnswerState.wrong) {
      return AnimatedBuilder(
        animation: _shake,
        builder: (context, child) =>
            Transform.translate(offset: Offset(_shake.value, 0), child: child),
        child: card,
      );
    }

    if (state == _AnswerState.correct) {
      return AnimatedBuilder(
        animation: _pop,
        builder: (context, child) =>
            Transform.scale(scale: _pop.value, child: child),
        child: card,
      );
    }

    return card;
  }
}

enum _AnswerState { normal, correct, wrong, timeout }
