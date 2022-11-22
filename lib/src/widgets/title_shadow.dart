part of '../vertical_page_stepper.dart';

class _TitleShadow extends StatelessWidget {
  const _TitleShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 0.2,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: SizedBox.fromSize(size: const Size.fromHeight(0)),
    );
  }
}
