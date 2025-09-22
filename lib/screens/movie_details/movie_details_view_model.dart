import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/movies_api_manager.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsViewModel extends Cubit<States> {
  MovieDetailsViewModel() : super(InitState());
  MoviesApiManager apimanager = MoviesApiManager();
  Movie? movie;
  List<Movie> movies = [];

  getDetails(int movieId) async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      response = await apimanager.getHttp("movie_details.json", {
        "movie_id": movieId,
        'with_images': true,
        'with_cast': true,
      });
      if (response['status_message'] == "Query was successful") {
        movie = Movie.fromJson(response['data']['movie']);
        emit(SucessState());
      }
    } on DioException catch (e) {
      emit(
        ErrorState(e.response?.data["message"].toString() ?? "Unknown error"),
      );
    }
  }

  getSuggestions(int movieId) async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      response = await apimanager.getHttp("movie_suggestions.json", {
        "movie_id": movieId,
      });
      if (response['status_message'] == "Query was successful") {
        final moviesJson = response['data']['movies'] as List<dynamic>;
        movies = moviesJson.map((item) => Movie.fromJson(item)).toList();
        emit(SucessState());
      }
    }on DioException catch (e) {
      emit(
        ErrorState(e.response?.data["message"].toString() ?? "Unknown error"),
      );
    }
  }

  Future<void> launch(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
