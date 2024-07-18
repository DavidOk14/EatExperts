import 'package:flutter/material.dart';
import 'package:eatexperts/Screens/Search/search.dart';
import 'package:eatexperts/Screens/Cart/cart.dart';
import 'package:eatexperts/Screens/Orders/orders.dart';
import 'package:eatexperts/Screens/Startup/restaurantFinder.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    SearchPage(),
    CartPage(),
    OrdersPage(),
  ];

  // Initialize RestaurantFinder
  restaurantFinder _restaurantFinder = restaurantFinder();

  @override
  void initState() {
    super.initState();
    _loadNearbyRestaurants(); // Load nearby restaurants when HomePage initializes
  }

  void _loadNearbyRestaurants() async {
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      // Fetch nearby restaurants
      List<dynamic> restaurants = await _restaurantFinder.getNearbyRestaurants(latitude, longitude);

      for (var restaurant in restaurants) 
      {
        final name = restaurant['tags']['name'] ?? 'Unknown';
        final lat = restaurant['lat'];
        final lon = restaurant['lon'];
        print('Restaurant: $name, Location: Lat: $lat, Lon: $lon');
      }
    } catch (e) {
      print('Error loading nearby restaurants: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EatExperts'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/EElogo.png'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
