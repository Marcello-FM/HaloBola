import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

class HbButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? widthFactor;
  final bool outlined;

  const HbButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.widthFactor,
    this.outlined = false,
  });

  @override
  State<HbButton> createState() => _HbButtonState();
}

class _HbButtonState extends State<HbButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.94,
      upperBound: 1.0,
    )..value = 1.0;
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.reverse();
  void _onTapUp(TapUpDetails _) => _controller.forward();
  void _onTapCancel() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final bg = widget.backgroundColor ?? AppColors.accent;
    final fg = widget.foregroundColor ?? Colors.white;

    return FractionallySizedBox(
      widthFactor: widget.widthFactor ?? (r.isPhone ? 0.92 : 0.55),
      child: GestureDetector(
        onTapDown: widget.onPressed != null ? _onTapDown : null,
        onTapUp: widget.onPressed != null ? _onTapUp : null,
        onTapCancel: widget.onPressed != null ? _onTapCancel : null,
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Container(
            height: r.sp(50),
            decoration: BoxDecoration(
              color: widget.outlined ? Colors.transparent : bg,
              borderRadius: AppShapes.button,
              border: widget.outlined
                  ? Border.all(color: bg, width: 2)
                  : null,
              boxShadow: widget.outlined || widget.onPressed == null
                  ? null
                  : [
                      BoxShadow(
                        color: bg.withValues(alpha:  0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      )
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon,
                      size: r.sp(20),
                      color: widget.outlined ? bg : fg),
                  SizedBox(width: r.sp(8)),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: r.sp(17),
                    fontWeight: FontWeight.w700,
                    color: widget.outlined ? bg : fg,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
