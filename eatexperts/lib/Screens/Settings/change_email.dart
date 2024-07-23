import 'package:flutter/material.dart';

class ChangeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _newEmail;

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'New Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newEmail = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save new email to database
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Email updated')));
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
