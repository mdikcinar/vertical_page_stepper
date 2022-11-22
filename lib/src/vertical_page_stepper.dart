import 'package:flutter/material.dart';

import 'package:vertical_page_stepper/vertical_page_stepper.dart';

part 'models/vertical_page_step.dart';

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
    pageController.addListener(() {
      if (!pageController.hasClients) return;
      pageValueNotifier.value = pageController.page ?? 0;
      if (currentStepNotifier.value != pageController.page!.round()) {
        currentStepNotifier.value = pageController.page!.round();
      }
    });
    indicatorInitialPositions = List.generate(widget.steps.length, (index) => 0);
    indicatorPositions = List.generate(widget.steps.length, (index) => null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var indicatorIndex = 0; indicatorIndex < widget.steps.length; indicatorIndex++) {
      calculateIndicatorsStartPositions(indicatorIndex, 0);
    }
  }

  @override
  void dispose() {
    if (widget.pageController == null) {
      pageController.dispose();
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
                    const TitleShadow()
                  ],
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  overscroll: false,
                  physics: const ClampingScrollPhysics(),
                ),
                scrollDirection: Axis.vertical,
                children: widget.steps.map((e) => e.content).toList(),
              ),
            ),
          ],
        ),
        for (var indicatorIndex = 0; indicatorIndex < widget.steps.length; indicatorIndex++)
          GestureDetector(
            onTap: () => animateToPage(indicatorIndex),
            child: ValueListenableBuilder<double>(
              valueListenable: pageValueNotifier,
              builder: (context, pageValue, child) {
                calculateIndicatorPositions(indicatorIndex, pageValue);
                final indicatorPosition =
                    indicatorPositions[indicatorIndex] ?? indicatorInitialPositions[indicatorIndex];
                return Padding(
                  padding: EdgeInsets.only(
                    left: widget.indicatorSettings.leftPadding,
                    top: indicatorPosition,
                  ),
                  child: Transform.scale(
                    scale: getIndicatorScale(indicatorIndex, pageValue),
                    child: CircleAvatar(
                      backgroundColor: getIndicatorBackgroundColor(indicatorIndex)
                          ?.withOpacity(getIndicatorColorOpacity(indicatorIndex, pageValue)),
                      radius: widget.indicatorSettings.activeRadius,
                      child: Opacity(
                        opacity: getIndicatorOpacity(indicatorIndex, pageValue),
                        child: widget.steps[indicatorIndex].indicator,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void animateToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: widget.pageChangeDuration,
      curve: widget.pageChangeCurve,
    );
  }

  Color? getIndicatorBackgroundColor(int indicatorIndex) =>
      widget.steps[indicatorIndex].indicatorBackgroundColor ?? widget.indicatorSettings.backgroundColor;

  void calculateIndicatorPositions(int indicatorIndex, double pageValue) {
    //This if is needed because sometimes page controller listener is not triggering on last pixels
    //If this happens reCorrect that value and return for initial position.
    if (pageValue <= indicatorIndex) {
      indicatorPositions[indicatorIndex] = indicatorInitialPositions[indicatorIndex];
      return;
    }
    const stepTitleBarHeight = 40;
    final indicatorHeight = widget.indicatorSettings.activeRadius * 2;
    final indicatorPaddingWithTitle = (stepTitleBarHeight - indicatorHeight) / 2;
    //This if is needed because sometimes page controller listener is not triggering on last pixels
    //If this happens reCorrect that value and return for title position.
    if (pageValue <= indicatorIndex || pageValue >= indicatorIndex + 1) {
      indicatorPositions[indicatorIndex] = indicatorPaddingWithTitle + (stepTitleBarHeight * indicatorIndex);
      return;
    }
    var newPosition = indicatorInitialPositions[indicatorIndex];
    if (pageValue > indicatorIndex && pageValue < indicatorIndex + 1) {
      newPosition += (newPosition - indicatorPaddingWithTitle - (stepTitleBarHeight * indicatorIndex)) *
          (indicatorIndex - pageValue);
    }
    indicatorPositions[indicatorIndex] = newPosition;
  }

  void calculateIndicatorsStartPositions(int indicatorIndex, double pageValue) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final safeAreaPaddings = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = deviceHeight - appBarHeight - safeAreaPaddings.top - safeAreaPaddings.bottom;
    final centerPosition = availableHeight / 2;
    final indicatorHeight = widget.indicatorSettings.activeRadius * 2;
    var indicatorInitialPosition = centerPosition;
    if (isIndicatorAboveCenter(indicatorIndex)) {
      indicatorInitialPosition -= indicatorHeight * ((widget.steps.length / 2 - 0.5) - indicatorIndex);
    } else if (isIndicatorBelowCenter(indicatorIndex)) {
      indicatorInitialPosition += indicatorHeight * (indicatorIndex - (widget.steps.length / 2 - 0.5));
    }
    indicatorInitialPositions[indicatorIndex] = indicatorInitialPosition;
  }

  bool isIndicatorAboveCenter(int indicatorIndex) {
    return indicatorIndex < (widget.steps.length / 2 - 0.5);
  }

  bool isIndicatorBelowCenter(int indicatorIndex) {
    return indicatorIndex > (widget.steps.length / 2 - 0.5);
  }

  double getIndicatorOpacity(int indicatorIndex, double pageValue) {
    if (indicatorIndex <= pageValue) {
      return 1;
    } else if (indicatorIndex >= pageValue + 1) {
      return 0;
    }
    return 1 - (indicatorIndex - pageValue);
  }

  double getIndicatorScale(int indicatorIndex, double pageValue) {
    final scale = widget.indicatorSettings.radius / widget.indicatorSettings.activeRadius;
    if (indicatorIndex <= pageValue) {
      return 1;
    } else if (indicatorIndex >= pageValue + 1) {
      return scale;
    }
    return scale + ((1 - scale) * (1 - (indicatorIndex - pageValue)));
  }

  double getIndicatorColorOpacity(int indicatorIndex, double pageValue) {
    var colorOpacity =
        widget.indicatorSettings.opacity + ((1 - widget.indicatorSettings.opacity) * (pageValue - indicatorIndex + 1));
    if (pageValue - indicatorIndex + 1 < 0) {
      colorOpacity = widget.indicatorSettings.opacity;
    } else if (pageValue - indicatorIndex + 1 > 1) {
      colorOpacity = 1;
    }
    return colorOpacity;
  }
}

class TitleShadow extends StatelessWidget {
  const TitleShadow({Key? key}) : super(key: key);

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
