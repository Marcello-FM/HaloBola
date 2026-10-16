import 'dart:math';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class ConfettiOverlay extends StatefulWidget {
  final bool trigger;
  final Widget child;

  const ConfettiOverlay({
    super.key,
    required this.trigger,
    required this.child,
  });

  @override
  State<ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<_Particle> _particles = [];
  final Random _rng = Random();
  static const int _count = 40;

  static const List<Color> _colors = [
    AppColors.accent,
    AppColors.accentYellow,
    AppColors.primary,
    AppColors.correctLight,
    Colors.white,
  ];

  void _spawn() {
    _particles.clear();
    for (int i = 0; i < _count; i++) {
      _particles.add(_Particle(
        x: _rng.nextDouble(),
        delay: _rng.nextDouble() * 0.4,
        color: _colors[_rng.nextInt(_colors.length)],
        size: _rng.nextDouble() * 6 + 4,
        swing: (_rng.nextDouble() - 0.5) * 0.15,
        spin: _rng.nextDouble() * 3,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void didUpdateWidget(ConfettiOverlay old) {
    super.didUpdateWidget(old);
    if (!old.trigger && widget.trigger) {
      _spawn();
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.trigger || _ctrl.isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _ctrl,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _ConfettiPainter(_particles, _ctrl.value),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _Particle {
  final double x;
  final double delay;
  final Color color;
  final double size;
  final double swing;
  final double spin;

  const _Particle({
    required this.x,
    required this.delay,
    required this.color,
    required this.size,
    required this.swing,
    required this.spin,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ConfettiPainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = ((progress - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      if (t <= 0) continue;
      final opacity = (1 - t * t).clamp(0.0, 1.0);
      final cx = size.width * p.x + sin(t * pi * 4) * size.width * p.swing;
      final cy = -20 + size.height * t * 1.1;
      final paint = Paint()
        ..color = p.color.withValues(alpha:  opacity)
        ..style = PaintingStyle.fill;
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(p.spin * t * pi * 2);
      final rect = Rect.fromCenter(
          center: Offset.zero, width: p.size, height: p.size * 0.6);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => true;
}
