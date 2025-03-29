import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/restaurant/restaurant_card.dart';
import 'package:buoi10/widget/date_picker.dart';
import 'package:buoi10/widget/time_picker.dart';
import 'package:buoi10/page/product/best_seller_item.dart';
import 'package:buoi10/data/service/product_service.dart';
import 'package:buoi10/page/reservation/reservation_confirm.dart';
import 'package:buoi10/data/model/reservation_model.dart';
import 'package:buoi10/page/reservation/reservation_bloc/reservation_bloc.dart';
import 'package:buoi10/page/reservation_history/reservation_history.dart';
import 'package:buoi10/route/route_management.dart';
import 'package:buoi10/widget/reservation_form.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/model/user_model.dart';

class ReservationPage extends StatefulWidget {
  final String name;
  final String address;
  final String imageUrl;

  const ReservationPage({
    required this.name,
    required this.address,
    required this.imageUrl,
    super.key,
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedGuests;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationBloc()..add(LoadReservations()),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Restaurant Details"),
          ),
          body: Column(
            children: [
              RestaurantCard(
                name: widget.name,
                address: widget.address,
                imageUrl: widget.imageUrl,
                isClickable: false,
              ),
              const TabBar(
                tabs: [
                  Tab(text: "Reservation"),
                  Tab(text: "Menu"),
                  Tab(text: "Review"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildReservationTab(),
                    _buildMenuTab(),
                    _buildReviewTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationTab() {
    return BlocConsumer<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationAddSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.reservationHistory);
        }
      },
      builder: (context, state) {
        return ReservationForm(
          restaurantName: widget.name,
          onReservationConfirmed: (reservation) {
            ConfirmationDialog.show(context, reservation);
          },
        );
      },
    );
  }


  Widget _buildMenuTab() {
    return FutureBuilder<List<dynamic>>(
      future: ProductService().fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading menu"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No menu items available"));
        } else {
          final foodItems = snapshot.data!;
          int? selectedIndex;

          return StatefulBuilder(
            builder: (context, setState) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  return BestSellerItem(
                    item: foodItems[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _buildReviewTab() {
    return Center(
      child: Text(
        "Reviews will be displayed here",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
