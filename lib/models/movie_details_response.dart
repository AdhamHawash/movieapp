import 'package:movieapp/models/movie_model.dart';

class MovieDetailsResponse {
  final String status;
  final String statusMessage;
  final Movie movie;

  MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    required this.movie,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      movie: Movie.fromJson(json['data']['movie']),
    );
  }
}