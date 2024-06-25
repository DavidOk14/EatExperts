import 'package:flutter/material.dart';
import 'package:eatexperts/Screens/Login/login.dart';

void main() => runApp(EatExperts());

class EatExperts extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'EatExperts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}