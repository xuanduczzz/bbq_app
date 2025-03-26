import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buoi10/page/restaurant/restaurant_card.dart';
import 'package:buoi10/data/service/restaurant_service.dart';

class OurRestaurantPage extends StatefulWidget {
  @override
  _OurRestaurantPageState createState() => _OurRestaurantPageState();
}

class _OurRestaurantPageState extends State<OurRestaurantPage> {
  final RestaurantService apiService = RestaurantService();
  List<dynamic> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    try {
      List<dynamic> data = await apiService.fetchRestaurants();
      setState(() {
        restaurants = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Our restaurant',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                DropdownButton<String>(
                  value: 'ALL',
                  items: const [
                    DropdownMenuItem(value: 'ALL', child: Text('ALL')),
                  ],
                  onChanged: (value) {
                    // Logic xử lý khi chọn giá trị mới
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];

                  return RestaurantCard(
                    name: restaurant['name'] ?? 'Unknown',
                    address: restaurant['address'] ?? 'No address',
                    imageUrl: restaurant['image'] ?? 'assets/images/banner1.png',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
