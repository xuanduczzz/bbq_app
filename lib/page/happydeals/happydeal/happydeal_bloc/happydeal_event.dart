part of 'happydeal_bloc.dart';

abstract class HappyDealEvent {}

class LoadDeals extends HappyDealEvent {}
class SelectDeal extends HappyDealEvent {
  final Deal deal;
  SelectDeal(this.deal);
}
