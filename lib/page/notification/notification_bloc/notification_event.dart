part of 'notification_bloc.dart';

// Events
abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNotificationData extends NotificationEvent {}

class MarkAsReadItem extends NotificationEvent {
  final String itemId;
  MarkAsReadItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}


class MarkAsReadAll extends NotificationEvent {}