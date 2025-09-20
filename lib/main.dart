// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/screens/login/login_screen.dart';
import 'package:movieapp/screens/movie_details/movie_details.dart';
import 'package:movieapp/screens/register/register_screen.dart';
import 'package:movieapp/screens/forget_password.dart';
import 'package:movieapp/core/shared_preference.dart';
import 'package:movieapp/screens/reset_password/reset_password.dart';

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
          ForgetPassword.routeName:(context) => ForgetPassword(),
          MovieDetails.routeName:(context)=> MovieDetails()
        },
        initialRoute: MovieDetails.routeName
            // token == null ? LoginScreen.routeName : HomeScreen.routeName,
      ),
    );
  }
}
