import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 49, 103, 242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 3),
              child: AnimatedScale(
                scale: _scale,
                duration: const Duration(seconds: 3),
                curve: Curves.easeOutBack,
                child: Image.asset(
                  'assets/Logo GHCAS.png',
                  width: 450,
                  height: 450,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
