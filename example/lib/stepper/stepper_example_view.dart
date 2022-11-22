import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/steps/step_1.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
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
      steps: [
        const Step1(),
        const VerticalPageStep(
          indicator: Icon(Icons.accessibility, size: 15),
          title: StepTitleBar(
            title: Text(
              'Hizmet/Ürün',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.white,
          ),
          content: Center(child: Text('content 2S')),
        ),
        VerticalPageStep(
          indicator: Icon(Icons.error, size: 15),
          title: StepTitleBar(
            title: const Text(
              'Detay',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.grey.shade200,
          ),
          content: ColoredBox(
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data'),
              ],
            ),
          ),
        ),
        VerticalPageStep(
          indicator: const Icon(Icons.pages, size: 15),
          title: const StepTitleBar(
            title: Text(
              'Detay 2',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.white,
          ),
          content: ColoredBox(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data'),
              ],
            ),
          ),
        ),
        VerticalPageStep(
          indicator: const Icon(Icons.sell_rounded, size: 15),
          title: StepTitleBar(
            title: const Text(
              'Detay3',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.grey.shade200,
          ),
          content: ColoredBox(
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
