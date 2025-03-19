import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected; // Callback khi chọn giờ

  const TimePickerWidget({Key? key, required this.onTimeSelected}) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay(hour: 18, minute: 30);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Pick your time: "),
        TextButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime,
            );
            if (pickedTime != null) {
              setState(() {
                selectedTime = pickedTime;
              });
              widget.onTimeSelected(selectedTime); // Gửi giá trị ra ngoài
            }
          },
          child: const Text("Select Time"),
        ),
        const SizedBox(width: 10),
        Text(
          selectedTime.format(context),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
