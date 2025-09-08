import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/api_manager.dart';
import 'package:movieapp/shared_preference.dart';
import 'package:movieapp/states.dart';

class LoginViewModel extends Cubit<States> {
  LoginViewModel() : super(InitState());
  ApiManager apimanager = ApiManager();

  login(String email, String password) async {
    try {
      emit(LoadingState());
      Map<String,dynamic> response;
      response = await apimanager.postHttp("auth/login", {
        "email": email,
        "password": password,
      });
      if (response['message'] == "Success Login") {
        SharedPreference.setUser(response['data']);
        emit(SucessState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
