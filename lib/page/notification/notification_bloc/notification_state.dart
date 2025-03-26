part of 'notification_bloc.dart';

// States
abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends NotificationState {}

class Loading extends NotificationState {}

class FetchDataSuccess extends NotificationState {
  final List<NotificationModel> items; // Đúng kiểu dữ liệu
  FetchDataSuccess(this.items);

  @override
  List<Object> get props => [items];
}


class Failure extends NotificationState {
  final String message;
  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class MarkAsReadItemSuccess extends NotificationState {
  final String item;
  MarkAsReadItemSuccess(this.item);

  @override
  List<Object> get props => [item];
}

class MarkAsReadSuccess extends NotificationState {
  final List<String> items;
  MarkAsReadSuccess(this.items);

  @override
  List<Object> get props => [items];
}
