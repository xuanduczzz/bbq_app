import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/model/restaurant_model.dart';
import 'banner_item.dart';
import 'package:buoi10/page/home/product_home.dart';
import 'package:buoi10/page/restaurant/restaurant_card.dart';
import 'package:buoi10/page/happydeals/happydeal/widget/deal_card.dart';
import 'package:buoi10/page/product/best_seller_page.dart';
import '../restaurant/our_restaurant_page.dart';
import 'package:buoi10/page/drawer/drawer_widget.dart';
import 'package:buoi10/page/notification/notification_page.dart';
import 'package:buoi10/page/happydeals/happydeal/happy_deal_page.dart';
import 'package:buoi10/route/route_management.dart';
import 'package:buoi10/data/service/restaurant_service.dart';
import 'package:buoi10/data/service/product_service.dart';
import 'package:buoi10/data/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/happydeals/happydeal/happydeal_bloc/happydeal_bloc.dart';


class HomePage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HappyDealBloc()..add(LoadDeals()),
  child: Scaffold(
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


class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductService _productService = ProductService();
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = _productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load products'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available'));
        } else {
          List<Product> products = snapshot.data!..shuffle();
          return Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: products.take(5).map((product) {
                return ProductCard(
                  image: product.image ?? 'assets/images/default_product.png',
                  name: product.name ?? "Unknown Product",
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}


class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final RestaurantService _restaurantService = RestaurantService();
  late Future<List<Restaurant>> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = _restaurantService.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _restaurants,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No restaurants available'));
        } else {
          // Chỉ lấy 3 nhà hàng đầu tiên
          List<Restaurant> restaurants = snapshot.data!..shuffle(); // Xáo trộn danh sách
          return Column(
            children: restaurants.take(3).whereType<Restaurant>().map((restaurant) {
              return RestaurantCard(
                name: restaurant.nameRestaurant ?? "Unknown Restaurant",
                address: restaurant.address ?? "Unknown Address",
                imageUrl: restaurant.image ?? 'assets/images/default_image.png',
              );
            }).toList(),
          );

        }
      },
    );
  }
}

class HappyDeals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HappyDealBloc()..add(LoadDeals()),
      child: BlocBuilder<HappyDealBloc, HappyDealState>(
        builder: (context, state) {
          if (state is DealsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DealsLoaded) {
            final deals = state.deals?.where((deal) => deal?.id != null).take(3).toList() ?? [];

            if (deals.isEmpty) {
              return Center(child: Text("Không có deal nào!"));
            }

            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: deals.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return SizedBox(
                    width: 300, // Điều chỉnh chiều rộng tại đây
                    height: 140, // Điều chỉnh chiều cao tại đây (nếu cần)
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.discountScreen,
                          arguments: deal,
                        );
                      },
                      child: (deal.id != null && deal.id! % 2 == 0)
                          ? DealCard2(deal: deal)
                          : DealCard1(deal: deal),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("Không có deal nào!"));
          }
        },
      ),
    );
  }
}










