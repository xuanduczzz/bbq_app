import 'package:flutter/material.dart';

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
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int selectedDate = 25;
  String selectedTime = "18h30 - 19h00";
  int peopleCount = 2;
  bool vaccinePass = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reservation")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.imageUrl, width: double.infinity, height: 500),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.address,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Now Open - Closes At 10:00PM",
                              style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Text("4.5", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  Icon(Icons.star, color: Colors.white, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Taskbar (Reservation, Menu, Reviews)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab("Reservation", true),
                _buildTab("Menu", false),
                _buildTab("Reviews", false),
              ],
            ),

            SizedBox(height: 10),

            // Các yêu cầu đặc biệt
            _buildRequirement("Must Have Vaccinated Card"),
            _buildRequirement("Deposit For Reservation"),

            SizedBox(height: 15),

            // Chọn ngày
            Text("Pick your date", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                int day = 23 + index;
                return _buildDateButton(day);
              }),
            ),

            SizedBox(height: 15),

            // Chọn giờ
            Text("Pick your time", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedTime,
              isExpanded: true,
              items: ["18h30 - 19h00", "19h00 - 19h30", "19h30 - 20h00"]
                  .map((time) => DropdownMenuItem(value: time, child: Text(time)))
                  .toList(),
              onChanged: (value) => setState(() => selectedTime = value!),
            ),

            SizedBox(height: 15),

            // Chọn số lượng khách
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("How many people?", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    _buildCounterButton("-", () {
                      if (peopleCount > 1) setState(() => peopleCount--);
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("$peopleCount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    _buildCounterButton("+", () {
                      setState(() => peopleCount++);
                    }),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15),

            // Chọn vaccine pass
            Row(
              children: [
                Checkbox(value: vaccinePass, onChanged: (value) => setState(() => vaccinePass = value!)),
                Text("Vaccine green passes"),
              ],
            ),

            // Ghi chú
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: "Notes", border: OutlineInputBorder()),
              maxLines: 2,
            ),

            SizedBox(height: 15),

            // Thông tin người đặt
            Text("Your information", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            _buildTextField("Full name", nameController),
            _buildTextField("Phone number", phoneController),
            _buildTextField("Email", emailController),

            // Đồng ý điều khoản
            Row(
              children: [
                Checkbox(value: agreeTerms, onChanged: (value) => setState(() => agreeTerms = value!)),
                Text("I agree with restaurant "),
                TextButton(
                  onPressed: () {},
                  child: Text("terms of service", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Nút đặt chỗ
            ElevatedButton(
              onPressed: () {
                if (agreeTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Reservation Confirmed!")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You must agree to the terms.")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("RESERVE", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // Widget tab
  Widget _buildTab(String title, bool isSelected) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  // Widget yêu cầu đặc biệt
  Widget _buildRequirement(String text) {
    return Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.red)),
      ],
    );
  }

  // Widget chọn ngày
  Widget _buildDateButton(int day) {
    return GestureDetector(
      onTap: () => setState(() => selectedDate = day),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: selectedDate == day ? Colors.red : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text("$day", style: TextStyle(color: selectedDate == day ? Colors.white : Colors.black)),
            Text("TUE", style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  // Widget nút tăng giảm số người
  Widget _buildCounterButton(String symbol, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Text(symbol, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      color: Colors.red,
    );
  }

  // Widget nhập thông tin
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }
}
