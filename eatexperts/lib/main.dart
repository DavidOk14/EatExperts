// Routes
import 'package:eatexperts/Screens/Login/signup.dart';
import 'package:eatexperts/Screens/Login/login.dart';
import 'package:eatexperts/Screens/Startup/SplashScreen.dart';
import 'package:eatexperts/Screens/Preferences/preferences.dart';
import 'package:eatexperts/Screens/Home/home.dart'; // Add import for Home Page

// Window Management
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

// Firebase
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setDesktopWindowSize();

  //await Firebase.initializeApp();

  runApp(EatExperts());
}

Future<void> setDesktopWindowSize() async {
  // If running on a non-Mobile Device set size of window
  if (!(Platform.isIOS || Platform.isAndroid || kIsWeb)) {
    setWindowTitle("EatExperts");
    setWindowMinSize(const Size(540, 960));
    setWindowMaxSize(const Size(540, 960));
  }
}

class EatExperts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/splashscreen': (context) => SplashScreen(),
        '/preferences': (context) => PreferencesPage(),
        '/home': (context) => HomePage(), // Add the home route
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
