import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class Step3 extends VerticalPageStep {
  const Step3()
      : super(
          indicator: const Icon(Icons.sell_rounded, size: 15),
          title: const _Step3Title(),
          content: const _Step3Content(),
        );
}

class _Step3Title extends StatelessWidget {
  const _Step3Title({Key? key}) : super(key: key);

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

class _Step3Content extends StatelessWidget {
  const _Step3Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: const Center(
        child: Text('Content 3'),
      ),
    );
  }
}
