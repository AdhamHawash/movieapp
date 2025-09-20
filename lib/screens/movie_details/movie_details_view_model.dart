import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/movies_api_manager.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/models/movie_model.dart';

class MovieDetailsViewModel extends Cubit<States> {
  MovieDetailsViewModel():super(InitState());
  MoviesApiManager apimanager = MoviesApiManager();
  Movie? movie;

  getDetails(int movieId) async {
    try {
      emit(LoadingState());
      Map<String,dynamic> response;
      response = await apimanager.getHttp("movie_details.json",{"movie_id":movieId,'with_images':true,'with_cast':true});
      if (response['status_message'] == "Query was successful") {
        movie=Movie.fromJson(response['data']['movie']);
        emit(SucessState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}