import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/data/model/reservation_model.dart';
import 'package:buoi10/page/notification/helper/notification_extension.dart';
import 'package:buoi10/page/notification/notification_bloc/notification_bloc.dart';

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
        title: Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(MarkAsReadAll());
            },
            child: Text(
              "Mark as read",
              style: TextStyle(color: Colors.redAccent),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FetchDataSuccess) {
              final notifications = state.items;
              if (notifications.isEmpty) {
                return Center(child: Text("No notifications"));
              }
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(child: notifications[index].getNotificationMessage());
                },
              );
            } else if (state is Failure) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
