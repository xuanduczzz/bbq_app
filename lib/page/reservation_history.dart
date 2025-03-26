import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/page/reservation/reservation_bloc/reservation_bloc.dart';
import 'package:buoi10/data/model/reservation_model.dart';

class ReservationHistoryPage extends StatefulWidget {
  @override
  _ReservationHistoryScreenState createState() => _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryPage> {
  @override
  void initState() {
    super.initState();
    print("📥 Fetching reservations...");
    context.read<ReservationBloc>().add(FetchReservations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reservation History")),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          if (state is ReservationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ReservationLoaded) {
            final reservations = state.reservations;

            print("🟢 UI đã nhận danh sách Reservation: ${reservations.length}");

            if (reservations.isEmpty) {
              return Center(child: Text("No reservations found"));
            }

            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(reservation.restaurantInfo?.nameRestaurant ?? "Unknown Restaurant"),
                    subtitle: Text("People: ${reservation.peopleCount}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        if (reservation.id != null) {
                          context.read<ReservationBloc>().add(DeleteReservation(reservation.id!));
                        } else {
                          print("🚨 Lỗi: Reservation ID là null!");
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("Error loading reservations"));
        },
      ),
    );
  }
}
