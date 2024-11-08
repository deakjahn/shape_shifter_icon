import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ShapeShifterIcon extends StatefulWidget {
  final bool compiled;
  final bool state;
  final Duration duration;
  final List<String> assets;

  const ShapeShifterIcon({
    super.key,
    required this.state,
    this.duration = kThemeAnimationDuration,
    required this.assets,
  }) : compiled = false;

  const ShapeShifterIcon.compiled({
    super.key,
    required this.state,
    this.duration = kThemeAnimationDuration,
    required this.assets,
  }) : compiled = true;

  @override
  State<ShapeShifterIcon> createState() => _ShapeShifterIconState();
}

class _ShapeShifterIconState extends State<ShapeShifterIcon> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Future<List<Widget>> frames;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    animation = Tween<double>(
      begin: 0.0,
      end: (widget.assets.length - 1).toDouble(),
    ).animate(controller);
    if (widget.state) controller.animateTo(widget.assets.length - 1, duration: Duration.zero);

    frames = loadFrames();
  }

  Future<List<Widget>> loadFrames() async {
    return Future.wait(widget.assets.map((asset) async {
      try {
        return widget.compiled ? SvgPicture(AssetBytesLoader(asset)) : SvgPicture.asset(asset);
      } catch (e, _) {
        return Container();
      }
    }));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ShapeShifterIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      if (mounted && widget.state)
        controller.forward();
      else
        controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: frames,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container();
        else if (snapshot.hasData) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, _) => snapshot.data![animation.value.toInt()],
          );
        } else
          return Container();
      },
    );
  }
}