import 'package:flutter/material.dart';

class SelfAnimatedIcon extends StatefulWidget {
  final AnimatedIconData icon;
  final bool state;
  final Duration duration;

  const SelfAnimatedIcon({
    super.key,
    required this.icon,
    required this.state,
    this.duration = kThemeAnimationDuration,
  });

  @override
  State<SelfAnimatedIcon> createState() => _SelfAnimatedIconState();
}

class _SelfAnimatedIconState extends State<SelfAnimatedIcon> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.state) controller.animateTo(1.0, duration: Duration.zero);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SelfAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      if (mounted && widget.state)
        controller.forward();
      else
        controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedIcon(
        icon: widget.icon,
        progress: controller,
      );
}