// Routes
import 'package:eatexperts/Screens/Login/signup.dart';
import 'package:eatexperts/Screens/Login/login.dart';
import 'package:eatexperts/Screens/Startup/SplashScreen.dart';
import 'package:eatexperts/Screens/Preferences/preferences.dart';
import 'package:eatexperts/Screens/Home/home.dart';
import 'package:eatexperts/Screens/Settings/settings.dart';
import 'package:eatexperts/Screens/Settings/confirm_delete.dart';
import 'package:eatexperts/Screens/Settings/change_username.dart';
import 'package:eatexperts/Screens/Settings/change_display_name.dart';
import 'package:eatexperts/Screens/Settings/change_password.dart';
import 'package:eatexperts/Screens/Settings/change_email.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart'; // If using Realtime Database
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setDesktopWindowSize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(EatExperts());
}

Future<void> setDesktopWindowSize() async {
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
        '/preferences': (context) => PreferencesPage(),
        '/home': (context) => HomePage(),
        '/splashscreen': (context) => SplashScreen(),
        '/settings': (context) => SettingsPage(),
        '/confirmDelete': (context) => ConfirmDeletePage(),
        '/changeUsername': (context) => ChangeUsernamePage(),
        '/changeDisplayName': (context) => ChangeDisplayNamePage(),
        '/changePassword': (context) => ChangePasswordPage(),
        '/changeEmail': (context) => ChangeEmailPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class TestDatabase extends StatefulWidget {
  @override
  _TestDatabaseState createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Realtime Database instance
  // final DatabaseReference _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Database'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // For Firestore
                await _firestore.collection('testCollection').add({
                  'testField': 'Hello, Firestore!',
                });

                // For Realtime Database
                // await _database.child('testNode').set('Hello, Realtime Database!');
              },
              child: Text('Write to Database'),
            ),
            ElevatedButton(
              onPressed: () async {
                // For Firestore
                QuerySnapshot snapshot =
                    await _firestore.collection('testCollection').get();
                for (var doc in snapshot.docs) {
                  print(doc.data());
                }

                // For Realtime Database
                // DataSnapshot snapshot = await _database.child('testNode').once();
                // print(snapshot.value);
              },
              child: Text('Read from Database'),
            ),
          ],
        ),
      ),
    );
  }
}
