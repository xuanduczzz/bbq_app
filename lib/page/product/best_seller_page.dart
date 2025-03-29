import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buoi10/data/service/product_service.dart';
import 'package:buoi10/page/product/best_seller_item.dart';

class BestSellerPage extends StatefulWidget {
  const BestSellerPage({super.key});

  @override
  State<BestSellerPage> createState() => _BestSellerPageState();
}

class _BestSellerPageState extends State<BestSellerPage> {
  final ProductService apiService = ProductService();
  int? selectedIndex;
  List<dynamic> foodItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBestSellers();
  }

  Future<void> fetchBestSellers() async {
    try {
      List<dynamic> data = await apiService.fetchProducts();
      setState(() {
        foodItems = data;
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
        backgroundColor: const Color(0xFFF8ECE2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best Seller',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final item = foodItems[index];
                  return BestSellerItem(
                    item: item,
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
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
