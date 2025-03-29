import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/widget/reservation_form.dart';
import 'package:buoi10/page/reservation/reservation_confirm.dart';
import 'package:buoi10/page/reservation/reservation_bloc/reservation_bloc.dart';
import 'package:buoi10/page/happydeals/deal_reservation/dealreservation_bloc/dealreservation_bloc.dart';
import 'package:buoi10/data/service/restaurant_service.dart';
import 'package:buoi10/route/route_management.dart';
import 'package:buoi10/data/model/restaurant_model.dart';

class DealReservationScreen extends StatefulWidget {
  @override
  _DealReservationScreenState createState() => _DealReservationScreenState();
}

class _DealReservationScreenState extends State<DealReservationScreen> {
  String? selectedRestaurantId;
  String? selectedRestaurantName;
  final List<String> dealRestaurantIds = ["1", "3", "5"];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RestaurantBloc(RestaurantService())..add(LoadRestaurantsById(dealRestaurantIds)),
        ),
        BlocProvider(
          create: (context) => ReservationBloc()..add(LoadReservations()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Deal Reservation"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RestaurantLoaded) {
                    List<Restaurant> restaurants = state.restaurants;

                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: "Select a Restaurant"),
                      value: selectedRestaurantId ?? restaurants.first.id.toString(), // Đảm bảo không rỗng
                      items: restaurants.map((restaurant) => DropdownMenuItem(
                        value: restaurant.id.toString(),
                        child: Text(restaurant.nameRestaurant ?? "Unknown Restaurant"),
                      )).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedRestaurantId = value;
                            selectedRestaurantName = restaurants.firstWhere((r) => r.id.toString() == value).nameRestaurant;
                          });
                        }
                      },
                    );


                  } else if (state is RestaurantError) {
                    return Center(child: Text("Failed to load restaurants"));
                  }
                  return SizedBox();
                },
              ),
              const SizedBox(height: 20),
              if (selectedRestaurantName != null)
                Expanded(child: _buildReservationForm()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationForm() {
    return BlocConsumer<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationAddSuccess) {
          Navigator.pushNamed(context, AppRoutes.reservationHistory);
        }
      },
      builder: (context, state) {
        if (selectedRestaurantName == null) {
          return Center(child: Text("Please select a restaurant"));
        }
        return ReservationForm(
          restaurantName: selectedRestaurantName!,
          onReservationConfirmed: (reservation) {
            ConfirmationDialog.show(context, reservation);
          },
        );
      },
    );
  }
}
