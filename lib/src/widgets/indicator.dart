part of '../vertical_page_stepper.dart';

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.indicatorSettings,
    required this.indicatorIndex,
    required this.indicatorPosition,
    required this.pageValue,
    this.backgroundColor,
    this.onTap,
    this.child,
  }) : super(key: key);

  final double indicatorPosition;
  final double pageValue;
  final int indicatorIndex;
  final Color? backgroundColor;
  final StepperIndicatorSettings indicatorSettings;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: indicatorSettings.leftPadding,
          top: indicatorPosition,
        ),
        child: Transform.scale(
          scale: getIndicatorScale(),
          child: CircleAvatar(
            backgroundColor:
                backgroundColor?.withOpacity(getIndicatorColorOpacity()),
            radius: indicatorSettings.activeRadius,
            child: Opacity(
              opacity: getIndicatorOpacity(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  double getIndicatorOpacity() {
    if (indicatorIndex <= pageValue) {
      return 1;
    } else if (indicatorIndex >= pageValue + 1) {
      return 0;
    }
    return 1 - (indicatorIndex - pageValue);
  }

  double getIndicatorScale() {
    final scale = indicatorSettings.radius / indicatorSettings.activeRadius;
    if (indicatorIndex <= pageValue) {
      return 1;
    } else if (indicatorIndex >= pageValue + 1) {
      return scale;
    }
    return scale + ((1 - scale) * (1 - (indicatorIndex - pageValue)));
  }

  double getIndicatorColorOpacity() {
    var colorOpacity = indicatorSettings.opacity +
        ((1 - indicatorSettings.opacity) * (pageValue - indicatorIndex + 1));
    if (pageValue - indicatorIndex + 1 < 0) {
      colorOpacity = indicatorSettings.opacity;
    } else if (pageValue - indicatorIndex + 1 > 1) {
      colorOpacity = 1;
    }
    return colorOpacity;
  }
}
