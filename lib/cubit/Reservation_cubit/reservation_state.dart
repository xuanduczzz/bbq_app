import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Trạng thái đặt bàn
class ReservationState extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String note;
  final DateTime? date;
  final TimeOfDay? time;
  final int guests;
  final bool isConfirmed;

  const ReservationState({
    this.name = "",
    this.phone = "",
    this.email = "",
    this.note = "",
    this.date,
    this.time,
    this.guests = 1,
    this.isConfirmed = false,
  });

  ReservationState copyWith({
    String? name,
    String? phone,
    String? email,
    String? note,
    DateTime? date,
    TimeOfDay? time,
    int? guests,
    bool? isConfirmed,
  }) {
    return ReservationState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      note: note ?? this.note,
      date: date ?? this.date,
      time: time ?? this.time,
      guests: guests ?? this.guests,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }

  @override
  List<Object?> get props => [name, phone, email, note, date, time, guests, isConfirmed];
}