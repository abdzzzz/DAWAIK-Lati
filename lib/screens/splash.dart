import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'intro_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const routeName = "/SplashScreen";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => const IntroScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset(
          'assets/splash.gif',
          width: size.width * 0.6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
