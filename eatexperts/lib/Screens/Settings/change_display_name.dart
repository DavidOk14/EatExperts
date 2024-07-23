import 'package:flutter/material.dart';

class ChangeDisplayNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _newDisplayName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Display Name'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'New Display Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new display name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newDisplayName = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save new display name to database
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Display name updated')));
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
