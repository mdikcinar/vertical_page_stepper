import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class Step5 extends VerticalPageStep {
  const Step5()
      : super(
          indicator: const Icon(Icons.info, size: 15),
          title: const _Step5Title(),
          content: const _Step5Content(),
        );
}

class _Step5Title extends StatelessWidget {
  const _Step5Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepTitleBar(
      title: const Text(
        'Step 3',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.grey.shade200,
    );
  }
}

class _Step5Content extends StatelessWidget {
  const _Step5Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: const Center(
        child: Text('Content 5'),
      ),
    );
  }
}
