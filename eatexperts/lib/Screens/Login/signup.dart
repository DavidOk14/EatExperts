import 'dart:core';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eatexperts/Screens/Startup/restaurantFinder.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> 
{
  bool _showPassword = true;

  // Textbox Information -> Firebase
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String signUpStatusMsg = " ";

  // Initialize RestaurantFinder
  restaurantFinder _restaurantFinder = restaurantFinder();

  // Confirm that username is valid
  bool isUsernameValid(String username)
  {
    if(username.isEmpty)
    {
      setState(() 
      {
      signUpStatusMsg = "Username cannot be empty!";
      });
      return false;
    }
    else if(username.length < 3 || username.length > 20)
    {
      setState(() 
      {
      signUpStatusMsg = "Username must be 3-20 characters!";
      });
      return false;
    }
    else if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(username))
    {
      setState(() 
      {
      signUpStatusMsg = "Username characters are invalid! (a-zA-Z0-9 values accepted)";
      });
      return false;
    }

    return true;
  }

  // Confirm that password is valid
  bool isPasswordValid(String password)
  {
    if(password.isEmpty)
    {
      setState(() 
      {
      signUpStatusMsg = "Password cannot be empty!";
      });
      return false;
    }
    else if (password.length < 6)
    {
      setState(() 
      {
      signUpStatusMsg = "Password cannot be less than 6 characters!";
      });
      return false;
    }
    else if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*()-_=+]+$').hasMatch(password))
    {
      setState(() 
      {
      signUpStatusMsg = "Password must be alphanumeric or contain the following characters '!@#\$%^&*()-_=+'";
      });
      return false;
    }

    return true;
  }

  // Confirm that email is valid
  bool isEmailValid(String email)
  {
    if(email.isEmpty)
    {
      setState(() 
      {
      signUpStatusMsg = "Email cannot be empty!";
      });
      return false;
    }
    else if(!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email))
    {
      setState(() 
      {
      signUpStatusMsg = "Email format is invalid!";
      });
      return false;
    }

    return true;
  }

  // Store user data with email in firebase
  Future<void> storeUserWithEmail(User user, String username) async
  {
    try
    {
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users.doc(username).set(
        {
        'username': username,
        'email': user.email,
        });
    } 
    catch (e)
    {
      print('Failed to store user data: $e');
    }
  }


  // Function will process the validity of the data from the sign up to add into Firebase
  void processAccount() async
  {

    if(isUsernameValid(_usernameController.text))
      if(isEmailValid(_emailController.text))
        if(isPasswordValid(_passwordController.text))
          if(_confirmPasswordController.text == _passwordController.text)
          {
            try
            {
              UserCredential newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text,
              );

              // Upon successful sign up
              print("User signed up: ${newUser.user?.uid}");
              storeUserWithEmail(newUser.user!, _usernameController.text);
              _restaurantFinder.loadNearbyRestaurants(_usernameController.text);
              Navigator.pushReplacementNamed(context, '/preferences');
            }
            on FirebaseAuthException catch (e)
            {
              if (e.code == 'weak-password')
              {
                print('The password provided is too weak.');
                setState(() 
                {
                signUpStatusMsg = "The password provided is too weak.";
                });
              }
              if(e.code == 'email-already-in-use')
              {
                print('An account already exists with that email.');
                setState(() 
                {
                signUpStatusMsg = "An account already exists with that email.";
                });
              }
              else
              {
                print('Sign Up Error: $e');
                setState(() 
                {
                signUpStatusMsg = "Sign Up Error: $e";
                });
              }
            }
          }
        else
        {
          print('Passwords do not match');
          setState(() 
          {
          signUpStatusMsg = "Passwords do not match";
          });
        }
  }
    

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () 
          {
            Navigator.pushNamed(context, '/login');
          }
        ),
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
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
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
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
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle sign up and navigate to preferences
                        processAccount();
                        //Navigator.pushNamed(context, '/preferences');
                      },
                      child: Text('Create Account'),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  signUpStatusMsg,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
