import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Change Username'),
            onTap: () {
              // Navigate to change username page
            },
          ),
          ListTile(
            title: Text('Change Display Name'),
            onTap: () {
              // Navigate to change display name page
            },
          ),
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Navigate to change password page
            },
          ),
          ListTile(
            title: Text('Change Email'),
            onTap: () {
              // Navigate to change email page
            },
          ),
          ListTile(
            title: Text('Change Food Preference'),
            onTap: () {
              // Navigate to change food preference page
            },
          ),
          ListTile(
            title: Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushNamed(context, '/confirmDelete');
            },
          ),
        ],
      ),
    );
  }
}
