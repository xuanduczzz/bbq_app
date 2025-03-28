import 'package:flutter/material.dart';
import 'package:buoi10/page/home/home_page.dart';
import 'package:buoi10/page/login/login_page.dart';
import 'package:buoi10/page/login/sign_up.dart';
import 'package:buoi10/page/login/OnboardingScreen1.dart';
import 'package:buoi10/page/login/OnboardingScreen2.dart';
import 'package:buoi10/page/login/OnboardingScreen3.dart';
import 'package:buoi10/page/reservation/reservation_page.dart';
import 'package:buoi10/main.dart';
import 'package:buoi10/page/restaurant/our_restaurant_page.dart';
import 'package:buoi10/page/product/best_seller_page.dart';
import 'package:buoi10/page/happydeals/happydeal/happy_deal_page.dart';
import 'package:buoi10/page/notification/notification_page.dart';
import 'package:buoi10/page/reservation_history/reservation_history.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String onboarding = '/onboarding';
  static const String reservation = '/reservation';
  static const String bestSeller = '/best_seller';
  static const String ourRestaurant = '/our_restaurant';
  static const String happyDeals = '/happy_deals';
  static const String notifications = '/notifications';
  static const String reservationHistory = '/reservation_history';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case reservation:
        final args = settings.arguments as Map<String, String>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ReservationPage(
            name: args['name'] ?? '',
            address: args['address'] ?? '',
            imageUrl: args['imageUrl'] ?? '',
          ),
        );

      case ourRestaurant:
        return MaterialPageRoute(builder: (_) => OurRestaurantPage());
      case bestSeller:
        return MaterialPageRoute(builder: (_) => BestSellerPage());
      case happyDeals:
        return MaterialPageRoute(builder: (_) => HappyDealPage());
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case reservationHistory:
        return MaterialPageRoute(builder: (_) => ReservationHistoryPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
