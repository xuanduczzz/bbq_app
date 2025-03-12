import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantService {
  final String apiUrl = 'https://67ce3259125cd5af7579cb16.mockapi.io/restaurants';

  Future<List<dynamic>> fetchRestaurants() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
