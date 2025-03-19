import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Thêm callback

  const CustomDatePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime currentMonth = DateTime.now();
  int selectedIndex = 0; // Chỉ mục của ngày được chọn

  @override
  void initState() {
    super.initState();
    selectedIndex = DateTime.now().day - 1; // Mặc định là ngày hiện tại
  }

  List<DateTime> generateDates() {
    int totalDays = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    return List.generate(totalDays, (index) => DateTime(currentMonth.year, currentMonth.month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = generateDates();

    return Column(
      children: [
        // Chọn tháng & năm
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Pick your date", style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            DropdownButton<int>(
              value: currentMonth.month,
              items: List.generate(12, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text(DateFormat.MMMM().format(DateTime(2021, index + 1, 1))),
                );
              }),
              onChanged: (newValue) {
                setState(() {
                  currentMonth = DateTime(currentMonth.year, newValue!, 1);
                  selectedIndex = 0; // Reset về ngày đầu tháng
                });
              },
            ),
            const SizedBox(width: 10),
            DropdownButton<int>(
              value: currentMonth.year,
              items: [2024, 2025, 2026, 2027].map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  currentMonth = DateTime(newValue!, currentMonth.month, 1);
                  selectedIndex = 0; // Reset về ngày đầu tháng
                });
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Chọn ngày
        carousel.CarouselSlider.builder(
          itemCount: dates.length,
          itemBuilder: (context, index, realIndex) {
            DateTime date = dates[index];
            bool isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onDateSelected(date); // Gọi callback khi chọn ngày
              },
              child: Column(
                children: [
                  Text(
                    DateFormat.E().format(date).toUpperCase(), // Hiển thị thứ (MO, TU, ...)
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.red : Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      DateFormat.d().format(date),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: carousel.CarouselOptions(
            height: 80,
            viewportFraction: 0.15,
            enableInfiniteScroll: false,
            initialPage: selectedIndex,
          ),
        ),
      ],
    );
  }
}
