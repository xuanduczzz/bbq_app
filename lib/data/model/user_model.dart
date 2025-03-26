class User {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? avatarUrl;
  final String? phone;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.avatarUrl,
    this.phone,
  });

  /// Chuyển đổi từ JSON sang đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?, // Lưu ý: Không nên truyền password nếu không cần thiết
      avatarUrl: json['avatarUrl'] as String?,
      phone: json['phone'] as String?,
    );
  }

  /// Chuyển đổi từ đối tượng User sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'phone': phone,
      // 'password': password, // Nếu không cần lưu password, có thể loại bỏ trường này
    };
  }
}
