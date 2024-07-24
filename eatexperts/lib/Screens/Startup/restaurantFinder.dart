import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class restaurantFinder 
{
  int radius = 16093; // 10 mile radius in meters

  Future<Position> _getCurrentLocation() async 
  {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled)
      throw Exception('Location services are not enabled');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) 
    {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always)
        throw Exception('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  
Future<List<dynamic>> getNearbyRestaurants(double latitude, double longitude) async
{
  // Fetch restaurnts around location in pre-defined radius -- Overpass API
    final url = Uri.parse(
      'https://overpass-api.de/api/interpreter?data=[out:json];'
      '('
      '  node["amenity"="restaurant"](around:$radius,$latitude,$longitude);'
      '  node["amenity"="fast_food"](around:$radius,$latitude,$longitude);'
      ');'
      'out body;'
    );

    final response = await http.get(url);

    // Determine if restaurants could be found
    if (response.statusCode == 200) 
    {
      final data = jsonDecode(response.body);
      return data['elements'];
    } 
    else 
      throw Exception('Failed to load restaurants');
  }

  void loadNearbyRestaurants(String username) async 
  {
    try 
    {
      // Get current location
      //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //double latitude = position.latitude;
      //double longitude = position.longitude;

      // Mock UNT Coordinatines
      double latitude = 33.210880;
      double longitude = -97.147827;


      // Fetch nearby restaurants
      List<dynamic> restaurants = await getNearbyRestaurants(latitude, longitude);

      // Format and save restaurants in Firestore
      await _saveRestaurantsToFirestore(restaurants, username);
    } 
      catch (e) 
    {
      print('Error loading nearby restaurants: $e');
    }
  }

  List<String> getFormattedRestaurantsList(List<dynamic> restaurants)
  {
    String formattedRestaurants;

      // Prepare a list to store formatted restaurant data
      List<String> _formattedRestaurants = [];

      for (var restaurant in restaurants) 
      {
        final name = restaurant['tags']['name'] ?? 'Unknown';
        final diet = _getDietOption(restaurant['tags']);
        final formatted = '$name - $diet';
        _formattedRestaurants.add(formatted);
        print(formatted); // This prints the formatted restaurant name and diet
      }

      if(_formattedRestaurants.length == 0)
        _formattedRestaurants.add("No nearby restaurants found.");

    return _formattedRestaurants;
  }

  Future<void> _saveRestaurantsToFirestore(List<dynamic> restaurants, String username) async 
  {
    try 
    {
      // Prepare a list to store formatted restaurant data
      List<String> formattedRestaurants = [];

      for (var restaurant in restaurants) 
      {
        final name = restaurant['tags']['name'] ?? 'Unknown';
        final diet = _getDietOption(restaurant['tags']);
        final formatted = '$name - $diet';
        formattedRestaurants.add(formatted);
        print(formatted); // This prints the formatted restaurant name and diet
      }

      // Save the formatted restaurant list to Firestore
      await FirebaseFirestore.instance.collection('users').doc(username).collection('Restaurants').doc('In Area').set({
        'restaurant_list': formattedRestaurants,
      });

      print('Restaurants saved to Firestore successfully.');
    } catch (e) 
    {
      print('Error saving restaurants to Firestore: $e');
    }
  }

  String _getDietOption(Map<String, dynamic> tags) {
    if (tags.containsKey('diet:vegan') && tags['diet:vegan'] == 'yes') return 'Vegan';
    if (tags.containsKey('diet:vegetarian') && tags['diet:vegetarian'] == 'yes') return 'Vegetarian';
    if (tags.containsKey('diet:keto') && tags['diet:keto'] == 'yes') return 'Keto';
    if (tags.containsKey('amenity') && tags['amenity'] == 'fast_food') return 'Fast Food';
    return 'Restaurant'; // Default category if no specific dietary option is found
  }
}