import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
}
