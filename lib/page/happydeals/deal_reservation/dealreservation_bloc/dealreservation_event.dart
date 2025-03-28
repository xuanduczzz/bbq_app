

part of 'dealreservation_bloc.dart';



abstract class ReservationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateReservation extends ReservationEvent {
  final String reservationId;

  CreateReservation(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}

class LoadReservation extends ReservationEvent {}
