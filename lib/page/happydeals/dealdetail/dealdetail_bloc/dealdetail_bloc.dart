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
        imageUrl1: "https://drive.google.com/uc?export=view&id=1GMFMADPU0cdMbKLSbEkOMUgv1eP6Ls3z",
        dealDetail1: "Chi tiết deal 1",
        imageUrl2: "https://drive.google.com/file/d/1DURMoPLnDnzVRGdhXcOa_E52PgqJ4m-n/view?usp=sharing",
        dealDetail2: "Chi tiết deal 2",
        imageUrl3: "https://example.com/image3.jpg",
      );
      emit(DetailLoaded(dealData: event.deal));

    } catch (e) {
      emit(LoadFail("Lỗi tải dữ liệu"));
    }
  }
}
