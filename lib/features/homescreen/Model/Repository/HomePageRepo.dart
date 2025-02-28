import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePageRepository {
  final String apiUrl = 'http://api.quotable.io/random';

  Future<Map<String, dynamic>> fetchRandomQuote() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}