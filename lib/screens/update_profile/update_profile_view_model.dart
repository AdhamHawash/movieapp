import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/shared_preference.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/core/user_api_manager.dart';
import 'package:movieapp/models/user_model.dart';

class UpdateProfileViewModel extends Cubit<States> {
  UpdateProfileViewModel() : super(InitState());
  UserApiManager apimanager = UserApiManager();
  User? profile;

  getProfile() async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      response = await apimanager.getHttp("profile");
      if (response['message'] == "Profile fetched successfully") {
        profile = User.fromJson(response['data']);
        emit(SucessState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

  updateData(String name, String phone, int avaterId) async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      profile = User(
        name: name,
        phone: phone,
        avaterId: avaterId,
        id: profile?.id ?? "",
        email: profile?.email ?? "",
        password: profile?.password ?? "",
        createdAt: profile?.createdAt,
        updatedAt: profile?.updatedAt,
        v: profile?.v ?? 0,
      );
      response = await apimanager.patchHttp("profile", {
        "name": profile!.name,
        "phone": profile!.phone,
        "avaterId": profile!.avaterId,
      });
      if (response['message'] == "Profile updated successfully") {
        emit(SucessState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

  deleteAccount() async {
    try {
      emit(LoadingState());
      Map<String, dynamic> response;
      response = await apimanager.deleteHttp("profile");
      if (response['message'] == "Profile deleted successfully") {
        SharedPreference.clear();
        emit(SucessState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
