import 'package:movieapp/models/movie_model.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final List<Movie> movies;

  MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return MoviesResponse(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      movies: (data['movies'] as List<dynamic>? ?? [])
          .map((m) => Movie.fromJson(m))
          .toList(),
    );
  }
}