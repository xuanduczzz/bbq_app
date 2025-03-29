import 'package:buoi10/widget/time_picker.dart';
import 'package:flutter/material.dart';

import '../data/model/reservation_model.dart';
import '../data/model/restaurant_model.dart';
import '../data/model/user_model.dart';
import 'date_picker.dart';
class ReservationForm extends StatefulWidget {
  final String restaurantName;
  final Function(Reservation) onReservationConfirmed;

  const ReservationForm({
    Key? key,
    required this.restaurantName,
    required this.onReservationConfirmed,
  }) : super(key: key);

  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? selectedGuests;
  bool isChecked = false;

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    restaurantInfo: Restaurant(nameRestaurant: widget.restaurantName),
                    userInfo: User(phone: _phoneController.text, email: _emailController.text),
                    notes: _noteController.text,
                    starCount: 5,
                    amount: 200000,
                  );

                  widget.onReservationConfirmed(reservation);
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
  }
}
