import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:buoi10/data/model/reservation_model.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

// Bloc
class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final List<Reservation> _reservations = []; // Danh sách dùng chung

  ReservationBloc() : super(ReservationInitial()) {
    on<LoadReservations>((event, emit) async {
      emit(ReservationLoading());
      await Future.delayed(const Duration(seconds: 1)); // Giả lập tải dữ liệu
      emit(ReservationLoaded(List.from(_reservations)));
    });

    on<AddReservation>((event, emit) {
      _reservations.add(event.reservation);

      print("🟢 Đã thêm Reservation: ${event.reservation}"); // Kiểm tra dữ liệu có vào Bloc không
      print("📌 Tổng số Reservation hiện tại: ${_reservations.length}");

      emit(ReservationLoaded(List.from(_reservations)));
    });


    on<FetchReservations>((event, emit) {
      print("📥 Fetching reservations... Tổng số: ${_reservations.length}");
      emit(ReservationLoaded(List.from(_reservations)));
    });


    on<UpdateReservation>((event, emit) {
      for (var i = 0; i < _reservations.length; i++) {
        if (_reservations[i].id == event.reservation.id) {
          _reservations[i] = event.reservation;
          break;
        }
      }
      emit(ReservationLoaded(List.from(_reservations)));
    });

    on<DeleteReservation>((event, emit) {
      _reservations.removeWhere((r) => r.id == event.id);
      emit(ReservationLoaded(List.from(_reservations)));
    });
  }
}
