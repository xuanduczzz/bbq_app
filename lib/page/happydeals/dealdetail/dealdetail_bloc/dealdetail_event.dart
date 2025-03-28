part of 'dealdetail_bloc.dart';

abstract class DealDetailEvent extends Equatable {
  const DealDetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadDetail extends DealDetailEvent {
  final Deal deal; // Thay vì dealId, ta truyền cả đối tượng Deal

  LoadDetail({required this.deal});
}

