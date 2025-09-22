import 'package:dio/dio.dart';
import 'package:movieapp/core/shared_preference.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class UserApiManager {
  SharedPreference sharedPreference = SharedPreference();
  late Dio dio;

  UserApiManager() {
    dio = Dio();
    dio.options.baseUrl = "https://route-movie-apis.vercel.app/";
    dio.interceptors.add(TalkerDioLogger());
    String? token;
    token = SharedPreference.getUser();
    if (token != null) {
      dio.options.headers = {"Authorization": "Bearer $token"};
    }
  }

  dynamic postHttp(String endPoint, Map<String, dynamic> body) async {
    Response response = await dio.post(endPoint, data: body);
    return response.data;
  }

  dynamic patchHttp(String endPoint, Map<String, dynamic>? body) async {
    Response response = await dio.patch(endPoint, data: body);
    return response.data;
  }

   dynamic getHttp(String endPoint) async {
    Response response = await dio.get(endPoint);
    return response.data;
  }

  dynamic deleteHttp(String endPoint) async {
    Response response = await dio.delete(endPoint);
    return response.data;
  }
}
