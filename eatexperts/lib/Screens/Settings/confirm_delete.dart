import 'package:flutter/material.dart';

class ConfirmDeletePage extends StatefulWidget {
  @override
  _ConfirmDeletePageState createState() => _ConfirmDeletePageState();
}

class _ConfirmDeletePageState extends State<ConfirmDeletePage> {
  final TextEditingController _passwordController = TextEditingController();

  void _confirmDeletion() {
    // Logic to delete account
    final password = _passwordController.text;
    if (password.isNotEmpty) {
      // Perform deletion logic here
      // If successful:
      Navigator.pop(context);
      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account successfully deleted')),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Account Deletion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmDeletion,
              child: Text('Confirm Deletion'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red, // Set the primary color of the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
