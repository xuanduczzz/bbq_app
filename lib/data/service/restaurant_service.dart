import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buoi10/data/model/restaurant_model.dart';

class RestaurantService {
  final String apiUrl = 'https://67ce3259125cd5af7579cb16.mockapi.io/restaurants'; // Thay API của bạn

  Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Restaurant.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}

