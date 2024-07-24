import 'package:eatexperts/Data/food_prime_data.dart';
import 'package:eatexperts/Screens/Home/food_detail_page.dart';
import 'package:eatexperts/Widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool _showFilters = false;

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = SEARCH_FOOD_PRIME_DATA
        .where((element) =>
            element['title']!.contains(_searchController.text) ||
            element['title']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () 
          {
            Navigator.pushNamed(context, '/home');
          }
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _toggleFilters,
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showFilters) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilterChip(
                            label: Text('\$'), onSelected: (bool value) {}),
                        FilterChip(
                            label: Text('\$\$'), onSelected: (bool value) {}),
                        FilterChip(
                            label: Text('\$\$\$'), onSelected: (bool value) {}),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Dietary Restrictions',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10.0,
                      children: [
                        FilterChip(
                            label: Text('Vegetarian'),
                            onSelected: (bool value) {}),
                        FilterChip(
                            label: Text('Vegan'), onSelected: (bool value) {}),
                        FilterChip(
                            label: Text('Keto'), onSelected: (bool value) {}),
                        FilterChip(
                            label: Text('Dairy-Free'),
                            onSelected: (bool value) {}),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle View Results button press
                        },
                        child: Text('View Results'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard('Burger', 'assets/burger_ss.jpeg'),
                  _buildCategoryCard('Indian', 'assets/indian.jpeg'),
                  _buildCategoryCard('Desserts', 'assets/desserts.jpeg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Results',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildSearchResult(
                'Cheeseburger', '\$10', '20-30 mins', 'assets/cc_burger.jpeg'),
            _buildSearchResult('Butter Chicken', '\$15', '30-40 mins',
                'assets/butterchicken.jpeg'),
            _buildSearchResult(
                'Chocolate Cake', '\$8', '15-20 mins', 'assets/ccake.jpeg'),
            _searchController.text.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filteredData.map((searchData) {
                      return _searchItemWidget(searchData);
                    }).toList(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 120,
          child: Column(
            children: [
              Image.asset(imagePath,
                  height: 100, width: 120, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResult(
      String title, String price, String time, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: ListTile(
          leading:
              Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(title),
          subtitle: Text('$price - $time'),
        ),
      ),
    );
  }

  Widget _searchItemWidget(Map<String, String> data) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => FoodDetailPage(data: data)));
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${data['title']}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    const Text(
                        "Greek style pizza, new england style, pizza dough, feta cheese"),
                    const SizedBox(height: 5),
                    const Text("\$13",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/${data['image']}"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(width: double.infinity, height: 1, color: Colors.grey[350]),
        const SizedBox(height: 10),
      ],
    );
  }
}
