import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://yts.mx/api/v2';

  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list_movies.json'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final moviesList = jsonData['data']['movies'] as List<dynamic>;

        return moviesList.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}