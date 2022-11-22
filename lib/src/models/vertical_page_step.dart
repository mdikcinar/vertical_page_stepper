part of '../vertical_page_stepper.dart';

@immutable
class VerticalPageStep {
  /// Creates a step for a [VerticalPageStepper].
  ///
  /// The [title], [content] arguments must not be null.
  const VerticalPageStep({
    required this.title,
    required this.content,
    this.indicator,
    this.indicatorBackgroundColor,
  });

  /// The title of the step that typically describes it.
  final Widget title;

  /// The content of the step that appears below the [title].
  final Widget content;

  ///Indicator widget which is Inside a `CircleAvatar`.
  ///Commonly it's a icon
  final Widget? indicator;

  ///Defines step special indicator background color.
  ///
  ///This value will be override indicator color that inside `StepperIndicatorSettings`
  final Color? indicatorBackgroundColor;
}
