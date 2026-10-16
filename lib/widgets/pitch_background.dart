import 'package:flutter/material.dart';
import '../core/theme.dart';

class PitchBackground extends StatelessWidget {
  final Widget child;

  const PitchBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomPaint(
      painter: _PitchPainter(isDark: isDark),
      child: child,
    );
  }
}

class _PitchPainter extends CustomPainter {
  final bool isDark;
  _PitchPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.pitchLine(isDark)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);

    final circleRadius = size.width * 0.15;
    canvas.drawCircle(Offset(cx, cy), circleRadius, paint);

    final smallR = circleRadius * 0.12;
    canvas.drawCircle(Offset(cx, cy), smallR, paint);

    final topArcRect = Rect.fromCenter(
      center: Offset(cx, 0),
      width: circleRadius * 1.4,
      height: circleRadius * 0.8,
    );
    canvas.drawArc(topArcRect, 0, 3.14159, false, paint);

    final bottomArcRect = Rect.fromCenter(
      center: Offset(cx, size.height),
      width: circleRadius * 1.4,
      height: circleRadius * 0.8,
    );
    canvas.drawArc(bottomArcRect, 3.14159, 3.14159, false, paint);
  }

  @override
  bool shouldRepaint(_PitchPainter old) => old.isDark != isDark;
}

class DiagonalHeaderClipper extends CustomClipper<Path> {
  final double cutHeight;

  const DiagonalHeaderClipper({this.cutHeight = 18});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - cutHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DiagonalHeaderClipper old) => old.cutHeight != cutHeight;
}

class AngleBottomClipper extends CustomClipper<Path> {
  const AngleBottomClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 20);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(AngleBottomClipper old) => false;
}
