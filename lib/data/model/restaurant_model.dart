class Restaurant {
  String? id;
  String? nameRestaurant;
  String? descriptionRestaurant;
  String? address;
  String? image;

  Restaurant({
    this.id,
    this.nameRestaurant,
    this.descriptionRestaurant,
    this.address,
    this.image,
  });

  /// Chuyển đổi từ JSON sang đối tượng Restaurant
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String?,
      nameRestaurant: json['name'] as String?,
      descriptionRestaurant: json['description'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
    );
  }

  /// Chuyển đổi từ đối tượng Restaurant sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameRestaurant,
      'description': descriptionRestaurant,
      'address': address,
      'image': image,
    };
  }
}
