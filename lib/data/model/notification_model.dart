import 'package:buoi10/data/model/reservation_model.dart';

class NotificationModel {
  final Reservation? reservation;
  bool isRead = false;
  final DateTime? createdAt;

  NotificationModel({this.reservation,  this.isRead = false, this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation']) : null,
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'reservation': reservation?.toJson(),
      'isRead': isRead,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      reservation: reservation,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}


