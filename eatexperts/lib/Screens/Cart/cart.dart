import 'package:eatexperts/Screens/Cart/payment.dart';
import 'package:eatexperts/Widgets/button_container_widget.dart';
import 'package:eatexperts/theme/style.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, String>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    // Sample data for demonstration
    _cartItems = [
      {"title": "Pizza", "image": "pizza_popular_3.png", "price": "23.4"},
      {"title": "Burger", "image": "burger_popular_3.png", "price": "15.0"}
    ];
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Image.asset("assets/EElogo.png"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_cartItems.length} item${_cartItems.length > 1 ? 's' : ''} in the cart",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return _itemCartWidget(
                    title: item['title'],
                    image: item['image'],
                    price: item['price'],
                    onRemove: () => _removeItem(index),
                  );
                },
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "2", // Update this dynamically if needed
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Fee",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$0.00",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[350],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${_calculateTotal()}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ButtonContainerWidget(
              title: "Checkout",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentScreen()),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _itemCartWidget({
    String? title,
    String? price,
    String? image,
    VoidCallback? onRemove,
  }) {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            spreadRadius: 1.5,
            blurRadius: 6.5,
            color: Colors.grey[300]!,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("assets/$image", fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$title",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightGreyColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: primaryColorED6E1B,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text("Times Food"),
                  const SizedBox(height: 5),
                  Text(
                    "\$$price",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1),
                        ),
                        child: const Center(child: Icon(Icons.remove_outlined)),
                      ),
                      const SizedBox(width: 10),
                      const Text("1"),
                      const SizedBox(width: 10),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1),
                        ),
                        child: const Center(child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    return _cartItems.fold(
      0.0,
      (total, item) => total + double.parse(item['price'] ?? '0'),
    );
  }
}
