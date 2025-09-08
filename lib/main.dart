// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/home_screen.dart';
import 'package:movieapp/login/login_screen.dart';
import 'package:movieapp/register/register_screen.dart';
import 'package:movieapp/reset_password/reset_password.dart';
import 'package:movieapp/shared_preference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreference.init();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  String? token = SharedPreference.getUser();
  MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterScreen.routeName: (_) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          ResetPassword.routeName: (context) => ResetPassword(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
        initialRoute:
            token == null ? LoginScreen.routeName : HomeScreen.routeName,
      ),
    );
  }
}
