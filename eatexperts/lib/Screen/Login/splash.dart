import 'dart:async';
import 'package:eat_experts/Screen/On%20Boarding/on_boarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        ));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/EatExperts Icon.png", scale: 2,),
      )
    );
  }
}