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
          description: "Up to 20% OFF \nNo upper limit!",
          imageUrl: "https://drive.google.com/uc?export=view&id=15qnv-hsHXuxIr-P4RmdiQKNeJsOf37Lo",
        ),
        Deal(
          id: 2,
          name: "Buy 1 Get 1 Free",
          description: "Buy one, get one ",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Ul-wnONOarMYmEJHMwfQfsE6JDxIm0nE",
        ),
        Deal(
          id: 3,
          name: "Weekend Special",
          description: "Enjoy exclusive discounts \nthis weekend!",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Te9NCcloeCtXFuOpY4XOh5OxuH22DZei",
        ),
        Deal(
          id: 4,
          name: "Flash Sale",
          description: "Get 30% off on orders \nabove 20!",
          imageUrl: "https://drive.google.com/uc?export=view&id=15XuJkTG0vTfVlyeHnqdYsn91iCkCD-FZ",
        ),
        Deal(
          id: 5,
          name: "Member Exclusive",
          description: "Special deals \nfor VIP members!",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Ul-wnONOarMYmEJHMwfQfsE6JDxIm0nE",
        ),
        Deal(
          id: 6,
          name: "Free Delivery",
          description: "Enjoy free delivery ",
          imageUrl: "https://drive.google.com/uc?export=view&id=15XuJkTG0vTfVlyeHnqdYsn91iCkCD-FZ",
        ),
        Deal(
          id: 7,
          name: "Holiday Bonanza",
          description: "Huge discounts during \nthe holiday season!",
          imageUrl: "https://drive.google.com/uc?export=view&id=15XuJkTG0vTfVlyeHnqdYsn91iCkCD-FZ",
        ),
        Deal(
          id: 8,
          name: "Midnight Cravings",
          description: "Get 15% off on orders \nafter 10 PM!",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Te9NCcloeCtXFuOpY4XOh5OxuH22DZei",
        ),
        Deal(
          id: 9,
          name: "Student Discount",
          description: "Students get 10% off \non all orders!",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Ul-wnONOarMYmEJHMwfQfsE6JDxIm0nE",
        ),
        Deal(
          id: 10,
          name: "Combo Meal Deal",
          description: "Save up to 25% \nwith combo meals!",
          imageUrl: "https://drive.google.com/uc?export=view&id=1Te9NCcloeCtXFuOpY4XOh5OxuH22DZei",
        ),
      ]));
    });
  }
}

