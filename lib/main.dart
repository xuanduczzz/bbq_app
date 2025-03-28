import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'page/login/OnboardingScreen1.dart';
import 'page/login/OnboardingScreen2.dart';
import 'page/login/OnboardingScreen3.dart';
import 'package:buoi10/page/home/home_page.dart';
import 'package:buoi10/page/reservation/reservation_page.dart';
import 'package:buoi10/page/login/login_page.dart';
import 'package:buoi10/page/login/sign_up.dart';
import 'package:buoi10/cubit/Login_cubit/auth_cubit.dart';
import 'package:buoi10/page/reservation/reservation_bloc/reservation_bloc.dart';
import 'package:buoi10/page/notification/notification_bloc/notification_bloc.dart';
import 'package:buoi10/route/route_management.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..checkLoginStatus()),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.generateRoute,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/images/Logo.png',
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0xFFF6EFE8),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/Logo.png',
            width: 211,
            height: 102,
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                OnboardingScreen1(),
                OnboardingScreen2(),
                OnboardingScreen3(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                // Page Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.red,
                    dotColor: Colors.grey,
                  ),
                ),

                // Next button
                IconButton(
                  onPressed: () {
                    int nextPage = _controller.page!.toInt() + 1;
                    if (nextPage < 3) {
                      _controller.animateToPage(
                        nextPage,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
