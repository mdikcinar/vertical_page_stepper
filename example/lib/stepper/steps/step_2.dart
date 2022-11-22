import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class Step2 extends VerticalPageStep {
  const Step2()
      : super(
          indicator: const Icon(Icons.accessibility, size: 15),
          title: const _Step2Title(),
          content: const _Step2Content(),
        );
}

class _Step2Title extends StatelessWidget {
  const _Step2Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepTitleBar(
      title: Text(
        'Weights',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
    );
  }
}

class _Step2Content extends StatelessWidget {
  const _Step2Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content 2'),
    );
  }
}
