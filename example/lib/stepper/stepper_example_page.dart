import 'package:flutter/material.dart';
import 'package:vertical_page_stepper/vertical_page_stepper.dart';

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
    return ValueListenableBuilder(
      valueListenable: hasAppBarElevationNotifier,
      builder: (context, hasAppBarElevation, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
            backgroundColor: Colors.blueAccent,
            elevation: hasAppBarElevation ? null : 0,
          ),
          body: child,
        );
      },
      child: VerticalPageStepper(
        pageController: pageController,
        indicatorSettings: StepperIndicatorSettings(
          backgroundColor: Colors.grey.shade300,
          opacity: 0.5,
        ),
        steps: [
          VerticalPageStep(
            indicator: const Icon(Icons.access_alarm, size: 15),
            title: const StepTitleBar(
              title: Text(
                'Müşteri',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
            ),
            content: ColoredBox(
              color: Colors.blueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('data'),
                ],
              ),
            ),
          ),
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
      ),
    );
  }
}

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
