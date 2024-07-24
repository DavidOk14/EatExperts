import 'package:flutter/material.dart';
import 'package:eatexperts/Screens/Startup/restaurantFinder.dart';

class RestaurantDumpPage extends StatefulWidget {
  @override
  _RestaurantDumpPageState createState() => _RestaurantDumpPageState();
}

class _RestaurantDumpPageState extends State<RestaurantDumpPage> {
  // Initialize RestaurantFinder
  restaurantFinder _restaurantFinder = restaurantFinder();
  
  // List to hold formatted restaurant data
  List<String> _formattedRestaurants = [];
  
  // Mock UNT Coordinates
  double latitude = 33.210880;
  double longitude = -97.147827;

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      // Fetch nearby restaurants
      List<dynamic> restaurants = await _restaurantFinder.getNearbyRestaurants(latitude, longitude);
      
      // Get formatted restaurant list
      List<String> formattedRestaurants = _restaurantFinder.getFormattedRestaurantsList(restaurants);
      
      // Update state with the formatted restaurants
      setState(() {
        _formattedRestaurants = formattedRestaurants;
      });
    } catch (e) {
      print('Error fetching restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Dump'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _formattedRestaurants.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _formattedRestaurants.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_formattedRestaurants[index]),
                );
              },
            ),
      ),
    );
  }
}
