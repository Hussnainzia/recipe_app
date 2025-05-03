import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeService {
  static const String _baseUrl =
      'http://127.0.0.1:8000'; // Replace with your server URL

  static Future<String> getRecipe(List<String> ingredients) async {
    final url = Uri.parse('$_baseUrl/generate-recipe/');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'ingredients': ingredients}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['recipe'] ?? 'No recipe found';
      } else {
        throw Exception('Failed to fetch recipe');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
