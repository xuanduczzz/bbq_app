part of 'reservation_bloc.dart';

@immutable
abstract class ReservationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadReservations extends ReservationEvent {}

class FetchReservations extends ReservationEvent {}

class AddReservation extends ReservationEvent {
  final Reservation reservation;
  AddReservation(this.reservation);

  @override
  List<Object> get props => [reservation];
}

class UpdateReservation extends ReservationEvent {
  final Reservation reservation;
  UpdateReservation(this.reservation);

  @override
  List<Object> get props => [reservation];
}

class DeleteReservation extends ReservationEvent {
  final String id;
  DeleteReservation(this.id);

  @override
  List<Object> get props => [id];
}
