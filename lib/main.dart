import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation color;
  late Animation size;
  late Animation transform;
  late Animation opacity;

  @override
  void initState() {
    //When creating an AnimationController, you pass it a vsync argument.
    // The presence of vsync prevents offscreen animations from consuming unnecessary resources
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    color =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(controller);
    size = Tween<double>(begin: 0, end: 300)
    // Curves change how the animation value changes over time, making it faster and slower over a duration leading to a better look.
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    //A Tween interpolates between the range of data as used by the object being animated.
    // For example, a Tween might define an interpolation from red to blue, or from 0 to 255.
    transform = Tween<double>(begin: -200, end: 0).animate(controller);
    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animation'),
      ),
      body: _body(),
    );
  }

  Widget _body() => AnimatedBuilder(
        animation: controller,
        builder: (context, child) => ColoredBox(
          color: Colors.black87,
          child: Opacity(
            opacity: opacity.value,
            child: Transform.translate(
              offset: Offset(transform.value, transform.value),
              child: Transform.rotate(
                angle: controller.value * 2 * math.pi,
                child: Center(
                  child: Icon(
                    Icons.star,
                    color: color.value,
                    size: size.value,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
