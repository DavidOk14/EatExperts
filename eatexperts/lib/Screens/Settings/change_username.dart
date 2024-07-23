import 'package:flutter/material.dart';

class ChangeUsernamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _newUsername;

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Username'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'New Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newUsername = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save new username to database
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Username updated')));
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
