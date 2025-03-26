import 'package:flutter/material.dart' hide Notification;

import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/data/model/reservation_model.dart';

extension NotificationExtension on NotificationModel {
  Widget getNotificationMessage() {
    switch (reservation?.status) {
      case ReservationStatus.finished:
        return RichText(
            text: TextSpan(text: 'Reservation', children: [
              TextSpan(
                  text: ' #${reservation?.id} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'has been finished successfully. Review Now'),
            ]));
      case ReservationStatus.pending:
        return RichText(
            text: TextSpan(text: 'Reservation', children: [
              TextSpan(
                  text: ' #${reservation?.id} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                  'has been booked. Please pay the deposit in time to keep your seats.\n'),
              TextSpan(text: 'Total deposit: '),
              TextSpan(
                  text: '${reservation?.amount} VND',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]));
      case ReservationStatus.cancelled:
        return RichText(
            text: TextSpan(text: 'Reservation', children: [
              TextSpan(
                  text: ' #${reservation?.id} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'has been cancelled. Please contact support for assistance.'),
            ]));
      case ReservationStatus.deposited:
        return RichText(
            text: TextSpan(text: 'Reservation', children: [
              TextSpan(
                  text: ' #${reservation?.id} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'deposit has been received. Awaiting confirmation.'),
            ]));
      case ReservationStatus.confirmed:
        return RichText(
            text: TextSpan(text: 'Reservation', children: [
              TextSpan(
                  text: ' #${reservation?.id} ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'has been confirmed. Enjoy your experience!'),
            ]));
      default:
        return Text('Your reservation status is unknown. Please check again.');
    }
  }
}
