part of 'dealreservation_bloc.dart';


abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRestaurantsById extends RestaurantEvent {
  final List<String> restaurantIds; // Chỉ load những ID này

  LoadRestaurantsById(this.restaurantIds);

  @override
  List<Object> get props => [restaurantIds];
}

