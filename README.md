
# Vertical Page Stepper
A simple customizable stepper.

## Features

![](https://github.com/mdikcinar/vertical_page_stepper/raw/main/doc/gif.gif)

## Usage

Please check the [example](https://github.com/mdikcinar/vertical_page_stepper/tree/main/example/lib/stepper) project to better understand.

``` dart
VerticalPageStepper(
      pageController: pageController,
      indicatorSettings: StepperIndicatorSettings(
        backgroundColor: Colors.grey.shade300,
        opacity: 0.5,
      ),
      steps: const [
        Step1(),
        Step2(),
        Step3(),
        Step4(),
        Step5(),
      ],
    );
```    

Steps should extend `VerticalPageStep`
``` dart
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
```

Available `StepperIndicatorSettings`
``` dart
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
```
## Tasks

---

- [ ] Widget Tests
- [ ] Bouncing problem when change page with pageController

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)