import 'package:flutter/cupertino.dart';

@immutable
class PageIndicatorSettings {
  const PageIndicatorSettings({
    this.activeRadius = 12,
    this.radius = 8,
    this.leftPadding = 8,
    this.backgroundColor,
    this.opacity = 0.5,
  })  : assert(activeRadius > 0, 'indicatorActiveRadius can not be negative value'),
        assert(radius > 0, 'indicatorRadius can not be negative value'),
        assert(radius < activeRadius, 'indicatorActiveRadius must be bigger than indicatorRadius'),
        assert(opacity > 0, 'opacity can not be negative value'),
        assert(opacity < 1, 'opacity can not be bigger than 1');

  final double activeRadius;
  final double radius;
  final double leftPadding;
  final Color? backgroundColor;
  final double opacity;
}
