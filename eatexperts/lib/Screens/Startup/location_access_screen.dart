import 'package:eatexperts/Screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  Future<void> requestLocationPermission(BuildContext context) async {
    LocationPermission location;


    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled - prompt user to enable
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location services are not enabled."),
        ),
      );
      return;
    }

    // Check location permissions
    location = await Geolocator.checkPermission();
    if (location == LocationPermission.denied) {
      // Location permissions are denied - request permission
      location = await Geolocator.requestPermission();
      if (location != LocationPermission.whileInUse &&
          location != LocationPermission.always) {
        // Permission not granted - inform user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location permission is required."),
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
                      "assets/location_user_marker.png",
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
                            color: Color.fromARGB(255, 5, 5, 5).withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.delivery_dining_outlined,
                            color: Color.fromARGB(255, 5, 5, 5),
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
                            color: Color.fromARGB(255, 2, 2, 2).withOpacity(0.15),
                          ),
                          child: Icon(
                            Icons.store_outlined,
                            color: Color.fromARGB(255, 2, 2, 2),
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
                    backgroundColor: Color.fromARGB(255, 6, 6, 6),
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
