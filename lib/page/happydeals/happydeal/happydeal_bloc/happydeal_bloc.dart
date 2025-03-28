import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:buoi10/data/model/deal_model.dart';

part 'happydeal_event.dart';
part 'happydeal_state.dart';

class HappyDealBloc extends Bloc<HappyDealEvent, HappyDealState> {
  HappyDealBloc() : super(DealsLoading()) {
    on<LoadDeals>((event, emit) async {
      await Future.delayed(Duration(seconds: 1)); // Giả lập tải dữ liệu từ API
      emit(DealsLoaded([
        Deal(
          id: 1,
          name: "LAAARGE DISCOUNTS",
          description: "Upto 20% OFF \nNo upper limit!",
          imageUrl: "https://drive.google.com/uc?export=view&id=15qnv-hsHXuxIr-P4RmdiQKNeJsOf37Lo",
        ),
        Deal(
          id: 2,
          name: "Buy 1 Get 1 Free",
          description: "Mua 1 tặng 1 tất cả món ăn",
          imageUrl: "https://example.com/bogo.jpg",
        ),
      ]));
    });
  }
}

