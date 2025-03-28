part of 'dealreservation_bloc.dart';



abstract class ReservationState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReservationLoading extends ReservationState {}

class ReservationLoaded extends ReservationState {}

class ReservationSuccess extends ReservationState {}

class ReservationFail extends ReservationState {
  final String error;

  ReservationFail(this.error);

  @override
  List<Object> get props => [error];
}
