import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class Step4 extends VerticalPageStep {
  const Step4()
      : super(
          indicator: const Icon(Icons.pages, size: 15),
          title: const _Step4Title(),
          content: const _Step4Content(),
        );
}

class _Step4Title extends StatelessWidget {
  const _Step4Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepTitleBar(
      title: Text(
        'Step 4',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
    );
  }
}

class _Step4Content extends StatelessWidget {
  const _Step4Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content 4'),
    );
  }
}
