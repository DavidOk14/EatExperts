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
              Navigator.pushNamed(context, '/changeUsername');
            },
          ),
          ListTile(
            title: Text('Change Display Name'),
            onTap: () {
              Navigator.pushNamed(context, '/changeDisplayName');
            },
          ),
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              Navigator.pushNamed(context, '/changePassword');
            },
          ),
          ListTile(
            title: Text('Change Email'),
            onTap: () {
              Navigator.pushNamed(context, '/changeEmail');
            },
          ),
          ListTile(
            title: Text('Change Food Preference'),
            onTap: () {
              Navigator.pushNamed(context, '/preferences');
            },
          ),
          ListTile(
            title: Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushNamed(context, '/confirmDelete');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
