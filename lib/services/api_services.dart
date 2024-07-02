import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/diary_model.dart';

class ApiService {
  final String baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<List<DiaryModel>> getDiaries(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stories'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['listStory'];
      return body.map((dynamic item) => DiaryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load diaries: ${response.body}');
    }
  }

  Future<DiaryModel> createDiary(String token, String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stories'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'title': title, 'content': content}), // Mengubah 'description' menjadi 'content'
    );

    if (response.statusCode == 201) {
      return DiaryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create diary: ${response.body}');
    }
  }
}
