part of '../vertical_page_stepper.dart';

class _TitleShadow extends StatelessWidget {
  final List<BoxShadow>? boxShadow;
  const _TitleShadow({Key? key,this.boxShadow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 0.5,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: SizedBox.fromSize(size: const Size.fromHeight(0)),
    );
  }
}
