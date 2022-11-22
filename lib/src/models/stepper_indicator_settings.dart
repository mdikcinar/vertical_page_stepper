import 'package:flutter/cupertino.dart';

@immutable
class StepperIndicatorSettings {
  const StepperIndicatorSettings({
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

  ///Indicator's radius when step is current or passed
  final double activeRadius;

  ///Indicator's radius when its next step
  final double radius;

  ///Indicators padding value from left
  final double leftPadding;

  ///Indicator background color
  final Color? backgroundColor;

  ///Indicator background color opacity when its next step.
  ///
  ///This value will be 1 when step is current or passed
  final double opacity;
}
