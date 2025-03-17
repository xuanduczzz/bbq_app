import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static const String keyPhone = 'phone';
  static const String keyPassword = 'password';
  static const String keyFullName = 'full_name';
  static const String keyEmail = 'email';

  // Lưu thông tin người dùng
  static Future<void> saveUser(String phone, String password, String fullName, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyPhone, phone);
    await prefs.setString(keyPassword, password);
    await prefs.setString(keyFullName, fullName);
    await prefs.setString(keyEmail, email);
  }

  // Lấy số điện thoại đã lưu
  static Future<String?> getSavedPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPhone);
  }

  // Lấy mật khẩu đã lưu
  static Future<String?> getSavedPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPassword);
  }

  // Lấy họ tên đã lưu
  static Future<String?> getSavedFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyFullName);
  }

  // Lấy email đã lưu
  static Future<String?> getSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }

  // Kiểm tra thông tin đăng nhập
  static Future<bool> validateUser(String phone, String password) async {
    String? savedPhone = await getSavedPhone();
    String? savedPassword = await getSavedPassword();
    return phone == savedPhone && password == savedPassword;
  }

  // Xóa dữ liệu người dùng (khi đăng xuất)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyPhone);
    await prefs.remove(keyPassword);
    await prefs.remove(keyFullName);
    await prefs.remove(keyEmail);
  }
}
