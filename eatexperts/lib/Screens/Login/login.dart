import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget 
{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('EatExperts'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'EatExperts',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                  onChanged: (value) 
                  {
                    // Handle input change event
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Toggle Password Visibility Icon
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () 
                      {
                        setState(() 
                        {
                          // Toggle Password Visibility
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) 
                  {
                    // Handle input change event
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () 
                      {
                        // Handle login
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () 
                      {
                        // Handle sign up
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: !_showPassword,
                    onChanged: (bool? value) 
                    {
                      setState(() {
                        _showPassword = !value!;
                      });
                    },
                  ),
                  Text('Show Password'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}