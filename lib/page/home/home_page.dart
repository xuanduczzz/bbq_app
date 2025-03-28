import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'banner_item.dart';
import 'package:buoi10/page/product/product_card.dart';
import 'package:buoi10/page/restaurant/restaurant_card.dart';
import 'package:buoi10/widget/deal_card.dart';
import 'package:buoi10/page/product/best_seller_page.dart';
import '../restaurant/our_restaurant_page.dart';
import 'package:buoi10/page/drawer/drawer_widget.dart';
import 'package:buoi10/page/notification/notification_page.dart';
import 'package:buoi10/page/happydeals/happydeal/happy_deal_page.dart';
import 'package:buoi10/route/route_management.dart';


class HomePage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EFE8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 5),
            Text(
              "Dong Khoi St, District 1",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.notifications);
              }

          ),
        ],
      ),
      drawer: CustomDrawer(), // Thêm Drawer vào đây
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Banner
            Container(
              height: 150,
              child: PageView(
                controller: _pageController,
                children: [
                  BannerItem(image: 'assets/images/banner1.png'),
                  BannerItem(image: 'assets/images/banner2.png'),
                  BannerItem(image: 'assets/images/banner3.png'),
                ],
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.red,
                  dotHeight: 6,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Best Seller Section
            SectionHeader(
              title: "Best seller",
              onTapSeeAll: () {
                Navigator.pushNamed(context, AppRoutes.bestSeller);

              },
            ),
            ProductList(),
            SizedBox(height: 20),
            // Our Restaurant Section
            SectionHeader(
              title: "Our restaurant",
              onTapSeeAll: () {
                Navigator.pushNamed(context, AppRoutes.ourRestaurant);

              },
            ),
            RestaurantList(),
            SizedBox(height: 20),
            // Happy Deals Section
            SectionHeader(
                title: "Happy Deals",
                onTapSeeAll: () {
                  Navigator.pushNamed(context, AppRoutes.happyDeals);

                },
            ),
            HappyDeals(),
          ],
        ),
      ),
    );
  }
}


class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTapSeeAll;

  const SectionHeader({required this.title, this.onTapSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: Text("See All", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}


class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ProductCard(image: 'assets/images/beef_ribs.png', name: "Beef Ribs", location: "An BBQ Su Van Hanh"),
          ProductCard(image: 'assets/images/beef_bacon.png', name: "Beef Bacon", location: "An BBQ Dong Khoi"),
        ],
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RestaurantCard(name: "An BBQ Dong Khoi", address: "Vincom Center, No.70 Le Thanh Ton, District 1, HCMC",imageUrl: "assets/images/banner1.png"),
        RestaurantCard(name: "An BBQ Su Van Hanh", address: "No. 716 Su Van Hanh, District 10, HCMC",imageUrl: "assets/images/banner2.png"),
        RestaurantCard(name: "An BBQ Nguyen Van Cu", address: "No. 235 Nguyen Van Cu, District 10, HCMC",imageUrl: "assets/images/banner3.png"),
      ],
    );
  }
}

class HappyDeals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DealCard(title: "LAAARGE DISCOUNTS", description: "Upto 20% OFF\nNo upper limit!", color: Colors.red),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DealCard(title: "TRY NEW", description: "Explore unique\nFor new eaters", color: Colors.green),
        ),
      ],
    );
  }
}



