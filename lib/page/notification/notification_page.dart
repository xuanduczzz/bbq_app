import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/page/notification/notification_bloc/notification_bloc.dart';
import 'package:buoi10/page/notification/widgets/notification_card.dart'; // Import NotificationCard

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotificationData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(MarkAsReadAll());
            },
            child: const Text(
              "Mark as read",
              style: TextStyle(color: Colors.redAccent),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchDataSuccess) {
              final notifications = state.items;
              if (notifications.isEmpty) {
                return const Center(child: Text("No notifications"));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  return NotificationCard(
                    notification: notification, // Truyền toàn bộ object NotificationModel
                    time: notification.createdAt != null
                        ? "${notification.createdAt!.hour}:${notification.createdAt!.minute} ${notification.createdAt!.day}/${notification.createdAt!.month}/${notification.createdAt!.year}"
                        : "Unknown time",
                  );

                },
              );
            } else if (state is Failure) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: Colors.red)),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
