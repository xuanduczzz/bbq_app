class Product {
  final String? image;
  final String? name;
  final String? description;
  final int? reviewCount; // reviewCount cần được chuyển đổi sang int

  Product({
    this.image,
    this.name,
    this.description,
    this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      reviewCount: json['reviewCount'] is String
          ? int.tryParse(json['reviewCount']) // Chuyển từ String sang int
          : json['reviewCount'] as int?, // Nếu là int thì giữ nguyên
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'description': description,
      'reviewCount': reviewCount?.toString(), // Chuyển int về String nếu cần
    };
  }
}
