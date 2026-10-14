import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late final double _width;
  late final double _height;

  Responsive(this.context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
  }

  double get width => _width;
  double get height => _height;

  bool get isPhone => _width < 600;
  bool get isTablet => _width >= 600 && _width < 1024;
  bool get isDesktop => _width >= 1024;
  bool get isLandscape => _width > _height;
  bool get isWide => _width >= 600;

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;

  double sp(double size) {
    final base = _width < _height ? _width : _height;
    return base * size / 400;
  }

  double get horizontalPadding {
    if (isDesktop) return wp(20);
    if (isTablet) return wp(8);
    return wp(4);
  }

  double get cardBorderRadius => isPhone ? 16 : 20;
  double get iconSize => sp(28);
  double get titleFontSize => sp(22);
  double get bodyFontSize => sp(14);
  double get smallFontSize => sp(12);
}
