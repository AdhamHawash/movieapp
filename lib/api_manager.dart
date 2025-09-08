import 'package:dio/dio.dart';
import 'package:movieapp/shared_preference.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class ApiManager {
  SharedPreference sharedPreference = SharedPreference();
  late Dio dio;

  ApiManager() {
    dio = Dio();
    dio.options.baseUrl = "https://route-movie-apis.vercel.app/";
    dio.interceptors.add(TalkerDioLogger());
    String? token;
    token = SharedPreference.getUser();
    if (token != null) {
      dio.options.headers = {"Authorization": "Bearer $token"};
    }
  }

  dynamic postHttp(String endPoint, Map<String, dynamic> params) async {
    Response response = await dio.post(endPoint, data: params);
    return response.data;
  }

  dynamic patchHttp(String endPoint, Map<String, dynamic> params) async {
    Response response = await dio.patch(endPoint, data: params);
    return response.data;
  }
}
