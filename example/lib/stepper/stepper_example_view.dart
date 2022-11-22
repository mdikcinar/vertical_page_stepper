import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/steps/steps.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class StepperExampleView extends StatelessWidget {
  const StepperExampleView({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return VerticalPageStepper(
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
  }
}
