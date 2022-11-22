import 'package:flutter/material.dart';

class StepTitleBar extends StatelessWidget {
  const StepTitleBar({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);

  final Widget title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: SizedBox.fromSize(
          size: const Size.fromHeight(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: title,
          ),
        ),
      ),
    );
  }
}
