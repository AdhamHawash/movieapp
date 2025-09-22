import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/user_api_manager.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/models/user_model.dart';

class RegisterViewModel extends Cubit<States> {
  RegisterViewModel() : super(InitState());
  UserApiManager apimanager = UserApiManager();

  register(User user) async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      response = await apimanager.postHttp("auth/register", {
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "confirmPassword": user.password,
        "phone": user.phone,
        "avaterId": user.avaterId,
      });
      if (response['message'] == "User created successfully") {
        emit(SucessState());
      }
    } on DioException catch (e) {
      emit(
        ErrorState(e.response?.data["message"].toString() ?? "Unknown error"),
      );
    }
  }
}
