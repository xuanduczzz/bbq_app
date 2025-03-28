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
    // print("📥 Fetching reservations...");
    // context.read<ReservationBloc>().add(FetchReservations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationBloc>(
      create: (context) => ReservationBloc()..add(LoadReservations()),
      child: Scaffold(
      appBar: AppBar(title: Text("Reservation History")),
      body: Builder(
        builder: (context) {
          return BlocBuilder<ReservationBloc, ReservationState>(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ảnh nhà hàng
                          reservation.restaurantInfo?.image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.network(
                              reservation.restaurantInfo!.image!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                              : SizedBox(), // Không hiển thị nếu không có ảnh

                          ListTile(
                            title: Text(reservation.restaurantInfo?.nameRestaurant ?? "Unknown Restaurant",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text("📅 Ngày: ${reservation.createdDate ?? 'Chưa có thông tin'}"),
                                Text("⏰ Giờ: ${reservation.timeRange ?? 'Chưa có thông tin'}"),
                                Text("👥 Số người: ${reservation.peopleCount}"),
                                Text(
                                  "🔵 Trạng thái: ${reservation.status ?? 'Đang chờ'}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: reservation.status == "Đã xác nhận" ? Colors.green : Colors.orange,
                                  ),
                                ),
                              ],
                            ),
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
                        ],
                      ),
                    );

                  },
                );
              }
              return Center(child: Text("Error loading reservations"));
            },
          );
        }
      ),
    )
    );
  }
}
