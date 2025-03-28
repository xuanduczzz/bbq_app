import 'package:buoi10/data/model/restaurant_model.dart';
import 'package:buoi10/data/model/user_model.dart';

enum ReservationStatus {
  finished,
  pending,
  cancelled,
  deposited,
  confirmed;

  static ReservationStatus fromString(String status) {
    switch (status) {
      case 'finished':
        return ReservationStatus.finished;
      case 'pending':
        return ReservationStatus.pending;
      case 'cancelled':
        return ReservationStatus.cancelled;
      case 'deposited':
        return ReservationStatus.deposited;
      case 'confirmed':
        return ReservationStatus.confirmed;
      default:
        return ReservationStatus.pending;
    }
  }
}

class DealReservation {
  final String? id;
  DateTime? createdDate;
  DateTime? updatedDate;
  List<Restaurant>? restaurants; // Thay đổi từ một nhà hàng thành danh sách nhà hàng
  int? peopleCount;
  String? timeRange;
  ReservationStatus? status;
  User? userInfo;
  String? notes;
  int? starCount;
  int? amount;

  DealReservation({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.peopleCount,
    this.timeRange,
    this.status = ReservationStatus.pending,
    this.restaurants,
    this.userInfo,
    this.notes,
    this.starCount,
    this.amount,
  });

  /// Chuyển đổi từ JSON sang đối tượng Reservation
  static DealReservation fromJson(Map<String, dynamic> json) {
    return DealReservation(
      id: json['id'] as String?,
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : null,
      restaurants: json['restaurants'] != null
          ? (json['restaurants'] as List).map((r) => Restaurant.fromJson(r)).toList()
          : null, // Xử lý danh sách nhà hàng
      peopleCount: json['peopleCount'] as int?,
      timeRange: json['timeRange'] as String?,
      status: ReservationStatus.fromString(json['status'] as String),
      userInfo: json['userInfo'] != null ? User.fromJson(json['userInfo']) : null,
      notes: json['notes'] as String?,
      starCount: json['starCount'] as int?,
      amount: json['amount'] as int?,
    );
  }

  /// Chuyển đổi từ đối tượng Reservation sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'restaurants': restaurants?.map((r) => r.toJson()).toList(),
      'peopleCount': peopleCount,
      'timeRange': timeRange,
      'status': status?.name,
      'userInfo': userInfo?.toJson(),
      'notes': notes,
      'starCount': starCount,
      'amount': amount,
    };
  }
}
