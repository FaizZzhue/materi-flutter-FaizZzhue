import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  // Api key masing2
  static const String apiKey = "0bc8d1f981333373e4024a04fb009ed7";
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey")
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey")
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse("$baseUrl/popular/movie?api_key=$apiKey")
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search/movie?api_key=$apiKey&query=$query")
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}