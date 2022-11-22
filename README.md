
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