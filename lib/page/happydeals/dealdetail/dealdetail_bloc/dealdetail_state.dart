part of 'dealdetail_bloc.dart';

abstract class DealDetailState extends Equatable {
  const DealDetailState();
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DealDetailState {}

class DetailLoaded extends DealDetailState {
  final Deal dealData; // Thêm một tham số Deal

  DetailLoaded({required this.dealData});
}


class LoadSuccess extends DealDetailState {}

class LoadFail extends DealDetailState {
  final String error;
  const LoadFail(this.error);

  @override
  List<Object?> get props => [error];
}
