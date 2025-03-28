import 'deal_model.dart';
class DealDetailModel extends Deal {
  final String imageUrl1;
  final String dealDetail1;
  final String imageUrl2;
  final String dealDetail2;
  final String imageUrl3;

  DealDetailModel({
    required Deal deal,
    required this.imageUrl1,
    required this.dealDetail1,
    required this.imageUrl2,
    required this.dealDetail2,
    required this.imageUrl3,
  }) : super(
    id: deal.id,
    name: deal.name,
    description: deal.description,
    imageUrl: deal.imageUrl,
  );

  // Thêm getter để truy xuất dữ liệu của Deal
  Deal get deal => this;

  factory DealDetailModel.fromJson(Map<String, dynamic> json) {
    return DealDetailModel(
      deal: Deal(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
      ),
      imageUrl1: json['imageUrl1'],
      dealDetail1: json['dealDetail1'],
      imageUrl2: json['imageUrl2'],
      dealDetail2: json['dealDetail2'],
      imageUrl3: json['imageUrl3'],
    );
  }

  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'imageUrl1': imageUrl1,
      'dealDetail1': dealDetail1,
      'imageUrl2': imageUrl2,
      'dealDetail2': dealDetail2,
      'imageUrl3': imageUrl3,
    });
    return json;
  }
}
