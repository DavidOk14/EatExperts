import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatexperts/Screens/Startup/restaurantFinder.dart';

class LoginPage extends StatefulWidget 
{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> 
{
  bool _showPassword = true;

  // Textbox Information -> Firebase
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginStatusMessage = '';

  // Initialize RestaurantFinder
  restaurantFinder _restaurantFinder = restaurantFinder();


// Function to login to account using Firebase
  Future<void> _verifyLogin() async 
  {
    // Username password text fields
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    try 
    {
      // Check if the username exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(username).get();

        // Get the email associated with the username
        String email = userDoc['email'];

        try 
        {
          // Sign in with email and password
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Load Restaurants and then navigate to HomePage on successful login
          _restaurantFinder.loadNearbyRestaurants(username);
          Navigator.pushReplacementNamed(context, '/home');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') 
          {
            setState(() 
            {
              _loginStatusMessage = 'Invalid username or password';
            });
          } 
          else 
          {
            setState(() 
            {
              _loginStatusMessage = 'Login failed : ${e.message}';
            });
          }
        }
    } catch (e) {
      setState(() 
      {
          _loginStatusMessage = 'Invalid username or password';
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
                  _loginStatusMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
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
                        _verifyLogin();
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
                      setState(() 
                      {
                        _showPassword = !value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap:()
                    {
                      setState(() 
                      {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Text('Show Password'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}