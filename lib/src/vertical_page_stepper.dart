import 'package:flutter/material.dart';

import 'package:vertical_page_stepper/vertical_page_stepper.dart';

part 'models/vertical_page_step.dart';
part 'widgets/indicator.dart';
part 'widgets/title_shadow.dart';

class VerticalPageStepper extends StatefulWidget {
  const VerticalPageStepper({
    Key? key,
    required this.steps,
    this.pageController,
    this.indicatorSettings = const StepperIndicatorSettings(),
    this.pageChangeDuration = const Duration(milliseconds: 500),
    this.pageChangeCurve = Curves.easeOut,
  }) : super(key: key);

  final List<VerticalPageStep> steps;
  final PageController? pageController;
  final StepperIndicatorSettings indicatorSettings;
  final Duration pageChangeDuration;
  final Curve pageChangeCurve;

  @override
  State<VerticalPageStepper> createState() => _VerticalPageStepperState();
}

class _VerticalPageStepperState extends State<VerticalPageStepper> {
  late PageController pageController;
  final ValueNotifier<int> currentStepNotifier = ValueNotifier(0);
  final ValueNotifier<double> pageValueNotifier = ValueNotifier(0);
  late final List<double> indicatorInitialPositions;
  late final List<double?> indicatorPositions;

  @override
  void initState() {
    super.initState();
    pageController = widget.pageController ?? PageController();
    pageController.addListener(pageValueListener);
    indicatorInitialPositions =
        List.generate(widget.steps.length, (index) => 0);
    indicatorPositions = List.generate(widget.steps.length, (index) => null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var indicatorIndex = 0;
        indicatorIndex < widget.steps.length;
        indicatorIndex++) {
      calculateIndicatorsStartPositions(indicatorIndex, 0);
    }
  }

  @override
  void dispose() {
    if (widget.pageController == null) {
      pageController
        ..removeListener(pageValueListener)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: currentStepNotifier,
              builder: (context, currentStep, child) {
                return Column(
                  children: [
                    for (var index = 0; index < currentStep; index++)
                      GestureDetector(
                        onTap: () => animateToPage(index),
                        child: widget.steps[index].title,
                      ),
                    const _TitleShadow()
                  ],
                );
              },
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  overscroll: false,
                  physics: const ClampingScrollPhysics(),
                ),
                scrollDirection: Axis.vertical,
                itemCount: widget.steps.length,
                itemBuilder: (context, index) => widget.steps[index].content,
              ),
            ),
          ],
        ),
        for (var indicatorIndex = 0;
            indicatorIndex < widget.steps.length;
            indicatorIndex++)
          ValueListenableBuilder<double>(
            valueListenable: pageValueNotifier,
            builder: (context, pageValue, child) {
              calculateIndicatorPositions(indicatorIndex, pageValue);
              final indicatorPosition = indicatorPositions[indicatorIndex] ??
                  indicatorInitialPositions[indicatorIndex];
              return _Indicator(
                indicatorSettings: widget.indicatorSettings,
                indicatorIndex: indicatorIndex,
                indicatorPosition: indicatorPosition,
                pageValue: pageValue,
                backgroundColor: getIndicatorBackgroundColor(indicatorIndex),
                onTap: () => animateToPage(indicatorIndex),
                child: widget.steps[indicatorIndex].indicator,
              );
            },
          ),
      ],
    );
  }

  void pageValueListener() {
    if (!pageController.hasClients) return;
    pageValueNotifier.value = pageController.page ?? 0;
    if (currentStepNotifier.value != pageController.page!.round()) {
      currentStepNotifier.value = pageController.page!.round();
    }
  }

  void animateToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: widget.pageChangeDuration,
      curve: widget.pageChangeCurve,
    );
  }

  Color? getIndicatorBackgroundColor(int indicatorIndex) =>
      widget.steps[indicatorIndex].indicatorBackgroundColor ??
      widget.indicatorSettings.backgroundColor;

  void calculateIndicatorPositions(int indicatorIndex, double pageValue) {
    //This if is needed because sometimes page controller listener is not triggering on last pixels
    //If this happens reCorrect that value and return for initial position.
    if (pageValue <= indicatorIndex) {
      indicatorPositions[indicatorIndex] =
          indicatorInitialPositions[indicatorIndex];
      return;
    }
    const stepTitleBarHeight = 40;
    final indicatorHeight = widget.indicatorSettings.activeRadius * 2;
    final indicatorPaddingWithTitle =
        (stepTitleBarHeight - indicatorHeight) / 2;
    //This if is needed because sometimes page controller listener is not triggering on last pixels
    //If this happens reCorrect that value and return for title position.
    if (pageValue <= indicatorIndex || pageValue >= indicatorIndex + 1) {
      indicatorPositions[indicatorIndex] =
          indicatorPaddingWithTitle + (stepTitleBarHeight * indicatorIndex);
      return;
    }
    var newPosition = indicatorInitialPositions[indicatorIndex];
    if (pageValue > indicatorIndex.toDouble() &&
        pageValue < indicatorIndex + 1) {
      newPosition += (newPosition -
              indicatorPaddingWithTitle -
              (stepTitleBarHeight * indicatorIndex)) *
          (indicatorIndex - pageValue);
    }
    indicatorPositions[indicatorIndex] = newPosition;
  }

  void calculateIndicatorsStartPositions(int indicatorIndex, double pageValue) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final safeAreaPaddings = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = deviceHeight -
        appBarHeight -
        safeAreaPaddings.top -
        safeAreaPaddings.bottom;
    final centerPosition = availableHeight / 2;
    final indicatorHeight = widget.indicatorSettings.activeRadius * 2;
    var indicatorInitialPosition = centerPosition;
    if (isIndicatorAboveCenter(indicatorIndex)) {
      indicatorInitialPosition -=
          indicatorHeight * ((widget.steps.length / 2 - 0.5) - indicatorIndex);
    } else if (isIndicatorBelowCenter(indicatorIndex)) {
      indicatorInitialPosition +=
          indicatorHeight * (indicatorIndex - (widget.steps.length / 2 - 0.5));
    }
    indicatorInitialPositions[indicatorIndex] = indicatorInitialPosition;
  }

  bool isIndicatorAboveCenter(int indicatorIndex) {
    return indicatorIndex < (widget.steps.length / 2 - 0.5);
  }

  bool isIndicatorBelowCenter(int indicatorIndex) {
    return indicatorIndex > (widget.steps.length / 2 - 0.5);
  }
}
