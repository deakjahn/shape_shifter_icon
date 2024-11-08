import 'package:flutter/material.dart';
import 'package:shape_shifter_icon/shape_shifter_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Shifter Icon Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shape Shifter Icon Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool buttonState1 = false;
  bool buttonState2 = false;
  bool buttonState3 = false;
  late List<String> assets;

  @override
  void initState() {
    super.initState();
    assets = List.generate(61, (index) => 'assets/$index.svg.vec');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Animated icon button', style: theme.textTheme.titleMedium),
            buildStockAnimated(),
            Text('Animated two-icon button', style: theme.textTheme.titleMedium),
            buildTwoIconAnimated(),
            Text('Shape shifter icon button', style: theme.textTheme.titleMedium),
            buildShapeShifter(),
          ],
        ),
      ),
    );
  }

  Widget buildStockAnimated() {
    return ElevatedButton(
      onPressed: () => setState(() {
        buttonState1 = !buttonState1;
      }),
      child: SelfAnimatedIcon(
        icon: AnimatedIcons.play_pause,
        state: buttonState1,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget buildTwoIconAnimated() {
    return ElevatedButton(
      onPressed: () => setState(() {
        buttonState2 = !buttonState2;
      }),
      child: SelfAnimatedTwoIcons(
        offIcon: Icon(Icons.pause, color: Colors.red),
        onIcon: Icon(Icons.play_arrow, color: Colors.green),
        state: buttonState2,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget buildShapeShifter() {
    return ElevatedButton(
      onPressed: () => setState(() {
        buttonState3 = !buttonState3;
      }),
      child: ShapeShifterIcon.compiled(
        state: buttonState3,
        duration: const Duration(seconds: 1),
        assets: assets,
      ),
    );
  }
}