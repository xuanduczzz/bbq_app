part of 'dealreservation_bloc.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

// Trạng thái khởi tạo
class RestaurantInitial extends RestaurantState {}

// Trạng thái đang tải danh sách nhà hàng
class RestaurantLoading extends RestaurantState {}

// Trạng thái tải danh sách nhà hàng thành công
class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

// Trạng thái lỗi khi tải danh sách nhà hàng
class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
