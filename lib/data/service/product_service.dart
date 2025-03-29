import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buoi10/data/model/product_model.dart';

class ProductService {
  final String apiUrl = 'https://67ce3259125cd5af7579cb16.mockapi.io/product'; // API URL

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);

        // Đảm bảo API trả về danh sách (List)
        if (jsonData is List) {
          return jsonData.map((item) {
            if (item is Map<String, dynamic>) {
              return Product.fromJson(item);
            } else {
              throw Exception("Invalid product data format");
            }
          }).toList();
        } else {
          throw Exception("Unexpected API response format");
        }
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products");
    }
  }
}
