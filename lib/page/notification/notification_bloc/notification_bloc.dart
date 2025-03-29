import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/page/notification/notification_data.dart'; // Import file notification_data.dart

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  List<NotificationModel> notifications = [];

  NotificationBloc() : super(Initial()) {
    on<FetchNotificationData>((event, emit) async {
      emit(Loading());
      try {
        notifications = await _loadNotifications();

        // Nếu chưa có dữ liệu trong SharedPreferences, dùng danh sách mẫu
        if (notifications.isEmpty) {
          notifications = List.from(sampleNotifications);
          await _saveNotifications();
        }
        emit(FetchDataSuccess(List.from(notifications)));
      } catch (e) {
        emit(Failure("Failed to fetch data"));
      }
    });

    on<MarkAsReadItem>((event, emit) async {
      try {
        await Future.delayed(Duration(milliseconds: 500));

        notifications = notifications.map((notif) {
          if (notif.reservation?.id == event.itemId) {
            return notif.copyWith(isRead: true);
          }
          return notif;
        }).toList();

        await _saveNotifications();
        emit(FetchDataSuccess(List.from(notifications)));
      } catch (e) {
        emit(Failure("Failed to mark item as read"));
      }
    });

    on<MarkAsReadAll>((event, emit) async {
      try {
        notifications = notifications.map((notif) => notif.copyWith(isRead: true)).toList();
        await _saveNotifications();
        emit(FetchDataSuccess(List.from(notifications)));
      } catch (e) {
        emit(Failure("Failed to mark all as read"));
      }
    });
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
    notifications.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('notifications', jsonList);
  }

  Future<List<NotificationModel>> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('notifications');
    if (jsonList == null) return [];
    return jsonList
        .map((e) => NotificationModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
