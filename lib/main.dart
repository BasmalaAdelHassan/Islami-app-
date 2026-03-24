import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islami App',
      home: OnboardingScreen(),
    );
  }
}