import 'dart:async';
import 'package:eatexperts/Screens/Startup/location_access_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LocationAccessScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Image.asset(
        "assets/EatExperts Icon.png",
        scale: 2,
      ),
    ));
  }
}
