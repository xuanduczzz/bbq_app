import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dealreservation_event.dart';
part 'dealreservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationLoading()) {
    on<CreateReservation>(_onCreateReservation);
    on<LoadReservation>(_onLoadReservation);
  }

  void _onCreateReservation(
      CreateReservation event, Emitter<ReservationState> emit) async {
    emit(ReservationLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(ReservationSuccess());
    } catch (e) {
      emit(ReservationFail("Failed to create reservation"));
    }
  }

  void _onLoadReservation(
      LoadReservation event, Emitter<ReservationState> emit) async {
    emit(ReservationLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(ReservationLoaded());
  }
}
