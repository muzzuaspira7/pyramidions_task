import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  ApiService(this.baseUrl);

  Future<List<dynamic>> get() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
            '(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final categoriesList = data['record']['categories'] as List;
      return categoriesList;
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }
}
