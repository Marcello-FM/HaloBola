import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../core/theme.dart';

class AppLogo extends StatefulWidget {
  final bool showName;
  final bool animate;

  const AppLogo({super.key, this.showName = true, this.animate = false});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _bounce = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _ctrl.forward();
      });
    } else {
      _ctrl.value = 1.0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final size = r.sp(88);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _bounce,
          builder: (context, child) => Transform.scale(
            scale: _bounce.value,
            child: child,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDeep],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(size * 0.22),
              child: Image.asset(
                'assets/images/ball.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.sports_soccer,
                  color: Colors.white,
                  size: size * 0.55,
                ),
              ),
            ),
          ),
        ),
        if (widget.showName) ...[
          SizedBox(height: r.sp(14)),
          Text(
            'HALA',
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: r.sp(40),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 4,
              height: 0.95,
            ),
          ),
          Text(
            'BOLA',
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: r.sp(40),
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 4,
              height: 0.95,
            ),
          ),
        ],
      ],
    );
  }
}