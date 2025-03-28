class Deal {
  final int id;
  final String name;
  final String description;
  final String imageUrl; // Thêm trường hình ảnh

  Deal({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'], // Lấy ảnh từ JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl, // Trả về ảnh khi chuyển thành JSON
    };
  }
}
