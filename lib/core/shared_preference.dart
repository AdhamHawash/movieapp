import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setUser(String token) async {
    await _prefs?.setString("token", token);
  }

  static String? getUser() {
    String? token = _prefs?.getString('token');
    return token;
  }

  static clear() async {
    await _prefs?.remove('token');
  }
}