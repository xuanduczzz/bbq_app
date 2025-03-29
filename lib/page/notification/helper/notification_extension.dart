import 'package:flutter/material.dart' hide Notification;
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/data/model/reservation_model.dart';

extension NotificationExtension on NotificationModel {
  Widget getNotificationMessage() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black), // Áp dụng màu đen mặc định
        children: _getMessageSpans(),
      ),
    );
  }

  List<TextSpan> _getMessageSpans() {
    List<TextSpan> spans = [
      const TextSpan(text: 'Reservation ', style: TextStyle(color: Colors.black)),
    ];

    if (reservation?.id != null) {
      spans.add(TextSpan(
        text: '#${reservation?.id} ',
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));
    }

    spans.add(TextSpan(
      text: _getStatusMessage(),
      style: const TextStyle(color: Colors.black),
    ));

    return spans;
  }

  String _getStatusMessage() {
    switch (reservation?.status) {
      case ReservationStatus.finished:
        return 'has been finished successfully. Review Now';
      case ReservationStatus.pending:
        return 'has been booked. Please pay the deposit in time to keep your seats.\nTotal deposit: ${reservation?.amount} VND';
      case ReservationStatus.cancelled:
        return 'has been cancelled. Please contact support for assistance.';
      case ReservationStatus.deposited:
        return 'deposit has been received. Awaiting confirmation.';
      case ReservationStatus.confirmed:
        return 'has been confirmed. Enjoy your experience!';
      default:
        return 'Your reservation status is unknown. Please check again.';
    }
  }
}
