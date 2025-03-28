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
      listener: (context,state){
        if(state is ReservationAddSuccess){
          Navigator.pushReplacementNamed(context, AppRoutes.reservationHistory);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomDatePicker(
                onDateSelected: (date) => setState(() => selectedDate = date),
              ),
              const SizedBox(height: 10),
              TimePickerWidget(
                onTimeSelected: (time) => setState(() => selectedTime = time),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: "Number of Guests"),
                value: selectedGuests,
                items: List.generate(10, (index) => index + 1)
                    .map((number) => DropdownMenuItem(
                  value: number,
                  child: Text("$number"),
                ))
                    .toList(),
                onChanged: (value) => setState(() => selectedGuests = value),
              ),
              const SizedBox(height: 10),
              TextField(controller: _noteController, decoration: const InputDecoration(labelText: "Note")),
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Full Name")),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone Number"), keyboardType: TextInputType.phone),
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email"), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) => setState(() => isChecked = value ?? false),
                  ),
                  const Text("I agree with restaurant terms of service"),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (isChecked && selectedDate != null && selectedTime != null && selectedGuests != null) {
                      Reservation reservation = Reservation(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        createdDate: DateTime.now(),
                        updatedDate: DateTime.now(),
                        peopleCount: selectedGuests!,
                        timeRange: "${selectedTime!.hour}:${selectedTime!.minute}",
                        status: ReservationStatus.pending,
                        restaurantInfo: Restaurant(nameRestaurant: widget.name),
                        userInfo: User(phone: _phoneController.text, email: _emailController.text),
                        notes: _noteController.text,
                        starCount: 5,
                        amount: 200000,
                      );


                      ConfirmationDialog.show(context, reservation);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields and accept the terms")),
                      );
                    }
                  },
                  child: const Text("RESERVE", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuTab() {
    return FutureBuilder<List<dynamic>>(
      future: ProductService().fetchBestSellers(),
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
