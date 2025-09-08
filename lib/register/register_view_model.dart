import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/api_manager.dart';
import 'package:movieapp/states.dart';
import 'package:movieapp/user_model.dart';

class RegisterViewModel extends Cubit<States> {
  RegisterViewModel() : super(InitState());
  ApiManager apimanager = ApiManager();

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
    } catch (e) {
      emit(ErrorState());
    }
  }
}
