import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'reservation_state.dart';

// Cubit quản lý trạng thái đặt bàn
class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(const ReservationState());

  void updateReservation({
    required String name,
    required String phone,
    required String email,
    required String note,
    required DateTime? date,
    required TimeOfDay? time,
    required int guests,
  }) {
    emit(state.copyWith(
      name: name,
      phone: phone,
      email: email,
      note: note,
      date: date,
      time: time,
      guests: guests,
      isConfirmed: false,
    ));
  }

  void confirmReservation() {
    emit(state.copyWith(isConfirmed: true));
  }
}