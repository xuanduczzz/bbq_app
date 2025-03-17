import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString('fullName');
    final email = prefs.getString('email');

    if (fullName != null && email != null) {
      emit(AuthLoggedIn(fullName, email));
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 2)); // Giả lập gọi API

    if (phone == "0123456789" && password == "password") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullName', "John Doe");
      await prefs.setString('email', "john.doe@example.com");

      emit(AuthLoggedIn("John Doe", "john.doe@example.com"));
    } else {
      emit(AuthError("Invalid phone number or password"));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(AuthLoggedOut());
  }
}
