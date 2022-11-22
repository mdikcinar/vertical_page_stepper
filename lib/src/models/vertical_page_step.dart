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
  ///
  /// Below the content, every step has a 'continue' and 'cancel' button.
  final Widget content;

  final Widget? indicator;

  final Color? indicatorBackgroundColor;
}
