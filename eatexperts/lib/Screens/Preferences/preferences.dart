import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> preferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Food Preferences'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              title: Text('Fast Food'),
              value: preferences.contains('Fast Food'),
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? preferences.add('Fast Food')
                      : preferences.remove('Fast Food');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Vegetarian'),
              value: preferences.contains('Vegetarian'),
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? preferences.add('Vegetarian')
                      : preferences.remove('Vegetarian');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Vegan'),
              value: preferences.contains('Vegan'),
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? preferences.add('Vegan')
                      : preferences.remove('Vegan');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Keto'),
              value: preferences.contains('Keto'),
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? preferences.add('Keto')
                      : preferences.remove('Keto');
                });
              },
            ),
            CheckboxListTile(
              title: Text('Non-Veg'),
              value: preferences.contains('Non-Veg'),
              onChanged: (bool? value) {
                setState(() {
                  value == true
                      ? preferences.add('Non-Veg')
                      : preferences.remove('Non-Veg');
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save preferences and navigate to home page
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
