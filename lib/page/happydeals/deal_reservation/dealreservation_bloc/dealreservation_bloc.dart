import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:buoi10/data/service/restaurant_service.dart';
import 'package:buoi10/data/model/restaurant_model.dart';

part 'dealreservation_event.dart';
part 'dealreservation_state.dart';



class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantService repository;

  RestaurantBloc(this.repository) : super(RestaurantInitial()) {
    on<LoadRestaurantsById>((event, emit) async {
      emit(RestaurantLoading());
      try {
        List<Restaurant> allRestaurants = await repository.fetchRestaurants(); // Lấy tất cả từ API
        List<Restaurant> filteredRestaurants = allRestaurants
            .where((restaurant) => event.restaurantIds.contains(restaurant.id))
            .toList(); // Lọc theo danh sách ID
        emit(RestaurantLoaded(filteredRestaurants));
      } catch (e) {
        emit(RestaurantError("Failed to load restaurants"));
      }
    });
  }
}

