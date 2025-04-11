import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<List<String>> searchRecipe(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        List<String> recipes = [];
        for (var meal in data['meals']) {
          recipes.add(meal['strMeal']);
        }
        return recipes;
      }
    }
    return [];
  }
}
