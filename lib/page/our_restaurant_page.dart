import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buoi10/widget/restaurant_card.dart';

class OurRestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
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
                    // Thêm logic xử lý khi chọn giá trị mới
                  },
                ),
              ],
            ),
            const SizedBox(height: 10), // Khoảng cách giữa tiêu đề và danh sách
            Expanded(
              child: ListView(
                children: [
                  RestaurantCard(
                    name: "An BBQ Dong Khoi",
                    address: "Vincom Center, No.70 Le Thanh Ton, District 1, HCMC",
                    imageUrl: "assets/images/banner1.png",
                  ),
                  RestaurantCard(
                    name: "An BBQ Su Van Hanh",
                    address: "No. 716 Su Van Hanh, District 10, HCMC",
                    imageUrl: "assets/images/banner2.png",
                  ),
                  RestaurantCard(
                    name: "An BBQ Nguyen Van Cu",
                    address: "No. 235 Nguyen Van Cu, District 10, HCMC",
                    imageUrl: "assets/images/banner3.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
