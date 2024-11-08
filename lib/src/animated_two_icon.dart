import 'package:flutter/material.dart';

class SelfAnimatedTwoIcons extends StatefulWidget {
  final Icon _offIcon;
  final Icon _onIcon;
  final bool state;
  final Duration duration;

  SelfAnimatedTwoIcons({
    super.key,
    required Icon offIcon,
    required Icon onIcon,
    required this.state,
    this.duration = kThemeAnimationDuration,
  })  : _offIcon = offIcon.copyWithKey(),
        _onIcon = onIcon.copyWithKey();

  @override
  State<SelfAnimatedTwoIcons> createState() => _SelfAnimatedTwoIconsState();
}

class _SelfAnimatedTwoIconsState extends State<SelfAnimatedTwoIcons> {
  late Widget currentIcon;

  @override
  void initState() {
    super.initState();

    currentIcon = widget.state ? widget._onIcon : widget._offIcon;
  }

  @override
  void didUpdateWidget(covariant SelfAnimatedTwoIcons oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      if (mounted && widget.state)
        setState(() => currentIcon = widget._onIcon);
      else
        setState(() => currentIcon = widget._offIcon);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: widget.duration,
        child: currentIcon,
      );
}

extension _Icon on Icon {
  Icon copyWithKey() => Icon(
        icon,
        key: UniqueKey(),
        size: size,
        fill: fill,
        weight: weight,
        grade: grade,
        opticalSize: opticalSize,
        color: color,
        shadows: shadows,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        applyTextScaling: applyTextScaling,
      );
}