import 'package:flutter/material.dart';
import 'package:buoi10/widget/restaurant_card.dart';
import 'package:buoi10/widget/date_picker.dart';
import 'package:buoi10/widget/time_picker.dart';
import 'package:buoi10/widget/best_seller_item.dart';
import 'package:buoi10/data/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/cubit/Reservation_cubit/reservation_cubit.dart';
import 'package:buoi10/cubit/Reservation_cubit/reservation_state.dart';

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
    return DefaultTabController(
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
    );
  }

  Widget _buildReservationTab() {
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
                .map((number) =>
                DropdownMenuItem(
                  value: number,
                  child: Text("$number"),
                ))
                .toList(),
            onChanged: (value) => setState(() => selectedGuests = value),
          ),
          const SizedBox(height: 10),
          TextField(controller: _noteController,
              decoration: const InputDecoration(labelText: "Note")),
          TextField(controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name")),
          TextField(controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone),
          TextField(controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) =>
                    setState(() => isChecked = value ?? false),
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
                if (isChecked) {
                  _showConfirmationDialog(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please accept the terms of service")),
                  );
                }
              },
              child: const Text(
                  "RESERVE", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: _buildConfirmWidget(context),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("CANCEL"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                context.read<ReservationCubit>().confirmReservation();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reservation Confirmed!")),
                );
              },
              child: const Text("CONFIRM"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildConfirmWidget(BuildContext context) {
    final reservation = context
        .watch<ReservationCubit>()
        .state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Your Reservation",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red),
            const SizedBox(width: 10),
            Expanded(child: Text(reservation.name.isNotEmpty
                ? reservation.name
                : "Not specified")),
          ],
        ),

        const SizedBox(height: 5),

        Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.red),
            const SizedBox(width: 10),
            Text(reservation.date != null
                ? "${reservation.date!.day}/${reservation.date!
                .month}/${reservation.date!.year}"
                : "Not selected"),
          ],
        ),

        const SizedBox(height: 5),

        Row(
          children: [
            const Icon(Icons.access_time, color: Colors.red),
            const SizedBox(width: 10),
            Text(reservation.time != null ? "${reservation.time!
                .hour}:${reservation.time!.minute}" : "Not selected"),
          ],
        ),

        const SizedBox(height: 5),

        Row(
          children: [
            const Icon(Icons.people, color: Colors.red),
            const SizedBox(width: 10),
            Text("${reservation.guests} People"),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    reservation.note.isNotEmpty ? reservation.note : "No Note"),
                Text(reservation.name.isNotEmpty
                    ? reservation.name
                    : "Your Name"),
                Text(reservation.phone.isNotEmpty
                    ? reservation.phone
                    : "Phone Number"),
                Text(
                    reservation.email.isNotEmpty ? reservation.email : "Email"),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          "Your deposit is 200.000VND",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        const SizedBox(height: 5),
        const Text(
            "Please pay within 30 minutes, if not, your reservation will be canceled automatically."),
      ],
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
          "Reviews will be displayed here", style: TextStyle(fontSize: 18)),
    );
  }
}