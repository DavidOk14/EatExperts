import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget 
{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  bool _showPassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _statusMessage = '';
  Color _statusColor = Colors.red;

// TODO: Make this test against the database
  Future<void> _testVerifyLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username == 'admin' && password == 'pass') {
      setState(() {
        _statusMessage = 'Login Successful';
        _statusColor = Colors.green;
      });
    } else {
      setState(() {
        _statusMessage = 'Invalid username or password';
        _statusColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
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
                  controller: _usernameController,
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
                  controller: _passwordController,
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
                child: Text(
                  _statusMessage,
                  style: TextStyle(color: _statusColor, fontSize: 16),
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
                        _testVerifyLogin();
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () 
                      {
                      Navigator.pushNamed(context, '/signup');
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