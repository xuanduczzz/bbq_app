import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:buoi10/data/model/notification_model.dart';
import 'package:buoi10/data/model/reservation_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

// Bloc
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  List<NotificationModel> notifications = [];

  NotificationBloc() : super(Initial()) {
    on<FetchNotificationData>((event, emit) async {
      emit(Loading());
      try {
        // Giả lập dữ liệu fetch
        await Future.delayed(Duration(seconds: 2));
        notifications = [
          NotificationModel(
              reservation: Reservation(
                  status: ReservationStatus.pending,
                  id: '23657865346',
                  amount: 690000)),
          NotificationModel(
              reservation: Reservation(
                  status: ReservationStatus.finished,
                  id: '111111111',
                  amount: 318516734816847)),
        ];
        emit(FetchDataSuccess(notifications.cast<NotificationModel>()));
      } catch (e) {
        emit(Failure("Failed to fetch data"));
      }
    });

    on<MarkAsReadItem>((event, emit) async {
      try {
        // Giả lập đánh dấu một item là đã đọc
        await Future.delayed(Duration(milliseconds: 500));
        emit(MarkAsReadItemSuccess("Item ${event.itemId}"));
      } catch (e) {
        emit(Failure("Failed to mark item as read"));
      }
    });

    on<MarkAsReadAll>((event, emit) async {
      try {
        // Giả lập đánh dấu tất cả là đã đọc
        await Future.delayed(Duration(milliseconds: 500));
        emit(MarkAsReadSuccess([]));
      } catch (e) {
        emit(Failure("Failed to mark all as read"));
      }
    });
  }
}

