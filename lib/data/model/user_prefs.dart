import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:buoi10/data/model/user_model.dart';

class UserPrefs {
  static const String keyUser = 'user_data';

  // Lưu thông tin người dùng dưới dạng JSON
  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = jsonEncode({
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'avatarUrl': user.avatarUrl,
      'phone': user.phone,
    });
    await prefs.setString(keyUser, userData);
  }

  // Lấy thông tin người dùng
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString(keyUser);
    if (userData == null) return null;

    Map<String, dynamic> data = jsonDecode(userData);
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      avatarUrl: data['avatarUrl'],
      phone: data['phone'],
    );
  }

  // Kiểm tra thông tin đăng nhập
  static Future<bool> validateUser(String phone, String password) async {
    User? savedUser = await getUser();
    return savedUser != null && savedUser.phone == phone && savedUser.password == password;
  }

  // Xóa dữ liệu người dùng (khi đăng xuất)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUser);
  }
}
