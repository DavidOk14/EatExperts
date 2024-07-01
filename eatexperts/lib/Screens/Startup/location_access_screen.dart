import 'dart:io';

import 'package:eatexperts/Screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  Future<void> requestLocationPermission(BuildContext context) async {
    Location location = new Location();
    
    PermissionStatus _permissionGranted;

    // Check if location services are enabled
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final serviceResult = await location.requestService();
      if (!serviceResult) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location services are required to proceed."),
          ),
        );
        return;
      }
    }

    // Check if location permissions are granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location permission is required to proceed."),
          ),
        );
        return;
      }
    }

    // If everything is granted, navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/EE_location.png",
                      height: 300,
                    ),
                    SizedBox(height: 32),
                    Text(
                      "Allow location access on the next screen for:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 154, 90, 203).withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.delivery_dining_outlined,
                            color: Color.fromARGB(255, 154, 90, 203),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Finding the best restaurants and shops near you",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 154, 90, 203).withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.store_outlined,
                            color: Color.fromARGB(255, 154, 90, 203),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Faster and more accurate delivery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(Platform.isAndroid || Platform.isIOS)
                      requestLocationPermission(context);
                    Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginPage(),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 154, 90, 203),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
