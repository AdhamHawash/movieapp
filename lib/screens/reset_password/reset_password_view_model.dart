import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/user_api_manager.dart';
import 'package:movieapp/core/states.dart';

class ResetPasswordViewModel extends Cubit<States> {
  ResetPasswordViewModel() : super(InitState());
  UserApiManager apimanager = UserApiManager();

  resetPassword(String oldPassword,String newPassword) async {
    try {
      emit(LoadingState());
      Map<String,dynamic> response;
      response = await apimanager.patchHttp("auth/reset-password", {
        "oldPassword":oldPassword,
        "newPassword":newPassword
      });
      if (response['message'] == "Password updated successfully") {
        emit(SucessState());
      }
    } on DioException catch (e) {
      emit(
        ErrorState(e.response?.data["message"].toString() ?? "Unknown error"),
      );
    }
  }
}
