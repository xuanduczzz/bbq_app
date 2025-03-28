part of 'happydeal_bloc.dart';

abstract class HappyDealState {}

class DealsLoading extends HappyDealState {}
class DealsLoaded extends HappyDealState {
  final List<Deal> deals;
  DealsLoaded(this.deals);
}


