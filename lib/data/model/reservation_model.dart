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

class Reservation {
  final String? id;
  DateTime? createdDate;
  DateTime? updatedDate;
  Restaurant? restaurantInfo;
  int? peopleCount;
  String? timeRange;
  ReservationStatus? status;
  User? userInfo;
  String? notes;
  int? starCount;
  int? amount;

  Reservation({
    this.id,
    this.createdDate,
    this.updatedDate,
    this.peopleCount,
    this.timeRange,
    this.status = ReservationStatus.pending,
    this.restaurantInfo,
    this.userInfo,
    this.notes,
    this.starCount,
    this.amount,
  });

  /// Chuyển đổi từ JSON sang đối tượng Reservation
  static Reservation fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as String?,
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : null,
      restaurantInfo: json['restaurantInfo'] != null ? Restaurant.fromJson(json['restaurantInfo']) : null,
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
      'restaurantInfo': restaurantInfo?.toJson(), // Giả sử Restaurant có phương thức toJson()
      'peopleCount': peopleCount,
      'timeRange': timeRange,
      'status': status?.name, // Chuyển enum thành chuỗi
      'userInfo': userInfo?.toJson(), // Giả sử User có phương thức toJson()
      'notes': notes,
      'starCount': starCount,
      'amount': amount,
    };
  }
}
