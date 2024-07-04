import 'package:flutter/material.dart';
import 'animation_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complex Particle Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationScreen(),
    );
  }
}