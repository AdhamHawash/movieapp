import 'package:dio/dio.dart';
import 'package:movieapp/core/shared_preference.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class MoviesApiManager {
  SharedPreference sharedPreference = SharedPreference();
  late Dio dio;

  MoviesApiManager() {
    dio = Dio();
    dio.options.baseUrl = "https://yts.mx/api/v2/";
    dio.interceptors.add(TalkerDioLogger());
  }

  dynamic getHttp(String endPoint, Map<String, dynamic> params) async {
    Response response = await dio.patch(endPoint, queryParameters: params);
    return response.data;
  }
}
