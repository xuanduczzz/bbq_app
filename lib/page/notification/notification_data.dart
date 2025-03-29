import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/data/model/reservation_model.dart';

List<NotificationModel> sampleNotifications = [
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.pending, id: '101', amount: 50000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.finished, id: '102', amount: 75000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.cancelled, id: '103', amount: 120000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.pending, id: '104', amount: 35000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.finished, id: '105', amount: 67000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.cancelled, id: '106', amount: 98000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.pending, id: '107', amount: 89000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.finished, id: '108', amount: 45000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.cancelled, id: '109', amount: 220000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
  NotificationModel(
    reservation: Reservation(status: ReservationStatus.pending, id: '110', amount: 31000),
    createdAt: DateTime.now(),
    isRead: false,
  ),
];
