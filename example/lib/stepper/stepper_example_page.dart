import 'package:flutter/material.dart';
import 'package:page_stepper_example/stepper/stepper_example_view.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late PageController pageController;
  final ValueNotifier<bool> hasAppBarElevationNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      if (!pageController.hasClients) return;
      if (pageController.page! > 0 && pageController.page! < 0.5) {
        hasAppBarElevationNotifier.value = true;
      } else {
        hasAppBarElevationNotifier.value = false;
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hasAppBarElevationNotifier,
      builder: (context, hasAppBarElevation, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
            backgroundColor: Colors.blueAccent,
            elevation: hasAppBarElevation ? null : 0,
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            },
          ),
          body: child,
        );
      },
      child: StepperExampleView(pageController: pageController),
    );
  }
}
