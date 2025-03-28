import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:buoi10/data/model/deal_detail_model.dart';

import '../../../../data/model/deal_model.dart';

part 'dealdetail_event.dart';
part 'dealdetail_state.dart';

class DealDetailBloc extends Bloc<DealDetailEvent, DealDetailState> {
  DealDetailBloc() : super(DetailLoading()) {
    on<LoadDetail>((event, emit) {
      emit(DetailLoaded(dealData: event.deal));
    });
  }

  Future<void> _onLoadDetail(LoadDetail event, Emitter<DealDetailState> emit) async {
    try {
      emit(DetailLoading());
      await Future.delayed(Duration(seconds: 2)); // Giả lập tải dữ liệu

      // Giả lập dữ liệu từ API hoặc database
      final dealData = DealDetailModel(
        deal: event.deal,
        imageUrl1: "https://example.com/image1.jpg",
        dealDetail1: "Chi tiết deal 1",
        imageUrl2: "https://example.com/image2.jpg",
        dealDetail2: "Chi tiết deal 2",
        imageUrl3: "https://example.com/image3.jpg",
      );
      emit(DetailLoaded(dealData: event.deal)); // ✅ Truyền đúng kiểu dữ liệu

    } catch (e) {
      emit(LoadFail("Lỗi tải dữ liệu"));
    }
  }
}
