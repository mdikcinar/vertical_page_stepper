import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/widgets/step_title_bar.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

class Step1 extends VerticalPageStep {
  const Step1()
      : super(
          indicator: const Icon(Icons.access_alarm, size: 15),
          title: const _Step1Title(),
          content: const _Step1Content(),
        );
}

class _Step1Title extends StatelessWidget {
  const _Step1Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StepTitleBar(
      title: Text(
        'Step 1',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blueAccent,
    );
  }
}

class _Step1Content extends StatelessWidget {
  const _Step1Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Name and Surname',
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Surname',
            ),
          ),
        ],
      ),
    );
  }
}
