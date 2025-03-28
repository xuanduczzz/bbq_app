import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buoi10/data/model/reservation_model.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final List<Reservation> _reservations = []; // Danh sách dùng chung

  ReservationBloc() : super(ReservationInitial()) {
    on<LoadReservations>((event, emit) async {
      emit(ReservationLoading());
      await _loadFromLocal();  // Load từ local storage
      emit(ReservationLoaded(List.from(_reservations)));
    });

    on<AddReservation>((event, emit) async {
      _reservations.add(event.reservation);
      await _saveToLocal(); // Lưu xuống local
      emit(ReservationAddSuccess(List.from(_reservations)));
    });

    on<FetchReservations>((event, emit) {
      emit(ReservationAddSuccess(List.from(_reservations)));
    });

    on<UpdateReservation>((event, emit) async {
      for (var i = 0; i < _reservations.length; i++) {
        if (_reservations[i].id == event.reservation.id) {
          _reservations[i] = event.reservation;
          break;
        }
      }
      await _saveToLocal();
      emit(ReservationLoaded(List.from(_reservations)));
    });

    on<DeleteReservation>((event, emit) async {
      _reservations.removeWhere((r) => r.id == event.id);
      await _saveToLocal();
      emit(ReservationLoaded(List.from(_reservations)));
    });

    _loadFromLocal(); // Load dữ liệu khi khởi tạo
  }

  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _reservations.map((r) => jsonEncode(r.toJson())).toList();
    await prefs.setStringList('reservations', jsonList);
  }

  Future<void> _loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('reservations');
    if (jsonList != null) {
      _reservations.clear();
      _reservations.addAll(jsonList.map((json) => Reservation.fromJson(jsonDecode(json))));
    }
  }
}
