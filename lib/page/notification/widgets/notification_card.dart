import 'package:buoi10/page/notification/helper/notification_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/page/notification/notification_bloc/notification_bloc.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final String time;

  const NotificationCard({super.key, required this.notification, required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NotificationBloc>().add(MarkAsReadItem(notification.reservation?.id ?? ""));
      },
      child: Card(
        color: notification.isRead ? Colors.white : Colors.brown[100], // Chưa đọc: Nâu, Đã đọc: Trắng
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shadowColor: Colors.grey[300],
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/Logo1.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: notification.getNotificationMessage(),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              time,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ),
      ),
    );
  }
}

