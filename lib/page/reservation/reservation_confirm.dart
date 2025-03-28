import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/reservation/reservation_bloc/reservation_bloc.dart'; // Đảm bảo import đúng file Bloc
import 'package:buoi10/data/model/reservation_model.dart';
import 'package:buoi10/page/reservation_history/reservation_history.dart';


class ConfirmationDialog {
  static void show(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ReservationBloc>(context),
          child: AlertDialog(
            content: ConfirmWidget(reservation: reservation),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("CANCEL"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  final bloc = context.read<ReservationBloc>();

                  // Thêm đặt chỗ vào Bloc
                  bloc.add(AddReservation(reservation));

                  // Đợi Bloc cập nhật xong rồi fetch lại danh sách
                  // Future.delayed(const Duration(milliseconds: 500), () {
                  //   bloc.add(FetchReservations());
                  //
                  //   // Chuyển trang sau khi Bloc đã cập nhật danh sách
                  //   Navigator.pop(dialogContext);
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ReservationHistoryPage(),
                  //     ),
                  //   );
                  //
                  // });
                },
                child: const Text("CONFIRM"),
              ),
            ],
          ),
        );
      },
    );
  }
}


class ConfirmWidget extends StatelessWidget {
  final Reservation reservation;

  const ConfirmWidget({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Your Reservation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            InfoRow(icon: Icons.location_on, text: reservation.restaurantInfo?.nameRestaurant ?? "Not specified"),
            InfoRow(
              icon: Icons.calendar_today,
              text: reservation.createdDate != null
                  ? "${reservation.createdDate!.day}/${reservation.createdDate!.month}/${reservation.createdDate!.year}"
                  : "Not selected",
            ),
            InfoRow(icon: Icons.access_time, text: reservation.timeRange ?? "Not selected"),
            InfoRow(icon: Icons.people, text: "${reservation.peopleCount} People"),

            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Maps.png"),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reservation.notes?.isNotEmpty == true ? reservation.notes! : "No Note"),
                    Text(reservation.userInfo?.email ?? "No Email"),
                    Text(reservation.userInfo?.phone ?? "No Phone"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Your deposit is 200.000VND", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            const SizedBox(height: 5),
            const Text("Please pay within 30 minutes, if not, your reservation will be canceled automatically."),
          ],
        );
      },
    );
  }
}


class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    );
  }
}

class SuccessDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext successContext) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Reservation Confirmed Successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(successContext),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}


