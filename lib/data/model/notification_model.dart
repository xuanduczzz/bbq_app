import 'package:buoi10/data/model/reservation_model.dart';

class NotificationModel {
  final Reservation? reservation;
  bool isRead = false;
  final DateTime? createdAt;

  NotificationModel({this.reservation,  this.isRead = false, this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      reservation: Reservation.fromJson(json['reservation']),
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservation': reservation?.toJson(),
      'isRead': isRead,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

