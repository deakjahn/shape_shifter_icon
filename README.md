# Shape Shifter Icon

The package provides three different animated icons that can be used as standalone widgets or inside buttons. It is self-contained, it doesn't rely on online services and repositories — you bundle your icons with your app.

![Screenshot](https://raw.githubusercontent.com/deakjahn/shape_shifter_icon/master/example/assets/sample/screen.gif "Screenshot")

## Standard animated icon

`SelfAnimatedIcon` encloses a standard Flutter `AnimatedIcon`, its only advantage is that it's self-contained and requires no external animation controller. You just construct it:

```dart
SelfAnimatedIcon(
  [key: ...,]
  icon: one of the AnimatedIcons constants,
  state: a boolean,
  /// optional duration, defaults to kThemeAnimationDuration
  duration: const Duration(seconds: 1)
);
```

## Icon animated between to icons

`SelfAnimatedTwoIcons` is rather similar to the standard animated icon above but it requires two simple icons and animates between the two using the usual Flutter crossfade animation.

```dart
SelfAnimatedTwoIcons(
  [key: ...,]
  offIcon: an Icon,
  onIcon: another Icon,
  state: a boolean,
  /// optional duration, defaults to kThemeAnimationDuration
  duration: const Duration(seconds: 1)
);
```

## Fully animated icon

`ShapeShifterIcon` is, of course, the pièce de resistance. You visit https://shapeshifter.design, create and export a shape shifter animation that morphs an icon into another. These work like the stock `AnimatedIcons`, only that you can have your own and you're not limited to the very few available in that class.

Using it is almost as simple as the ones above:

```dart
ShapeShifterIcon(
  [key: ...,]
  state: a boolean,
  assets: a list of asset names,
  /// optional duration, defaults to kThemeAnimationDuration
  duration: const Duration(seconds: 1)
);
```

You simply have to pass a list of SVG files representing the individual frames. Shape Shifter exports to 30 fps (10 files) and 60 fps (19 files). Naming them is up to you, you can put each icon into a separate folder, or just name them `iconname_framenumber.svg`, however you please. Just create a list of the names and pass it to the icon. It might be as simple as:

```dart
  final assets = List.generate(19, (index) => 'assets/$index.svg');
```

for the 60 fps version.

Just like the underlying `flutter_svg` package, this package also supports compiling the SVG file into a binary format to achieve smaller size and better loading performance, using [vector_graphics_compiler](https://pub.dev/packages/vector_graphics_compiler).

The only difference is that you need to call the `ShapeShifterIcon.compiled()` constructor instead:

```dart
ShapeShifterIcon.compiled(
  [key: ...,]
  state: a boolean,
  assets: a list of compiled asset names,
  /// optional duration, defaults to kThemeAnimationDuration
  duration: const Duration(seconds: 1)
);
```

Compiling is a single command:

```
dart run vector_graphics_compiler -i example/assets/0.svg -o example/assets/0.svg.vec
```

Don't forget that your file names will be different:


```dart
  final assets = List.generate(19, (index) => 'assets/$index.svg.vec');
```