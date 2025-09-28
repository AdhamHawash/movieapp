// ignore_for_file: must_be_immutable, equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/screens/onboarding.dart';
import 'package:movieapp/screens/home/home_screen.dart';
import 'package:movieapp/screens/login/login_screen.dart';
import 'package:movieapp/screens/movie_details/movie_details.dart';
import 'package:movieapp/screens/register/register_screen.dart';
import 'package:movieapp/screens/forget_password.dart';
import 'package:movieapp/core/shared_preference.dart';
import 'package:movieapp/screens/reset_password/reset_password.dart';
import 'package:movieapp/screens/update_profile/update_profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreference.init();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  String? token = SharedPreference.getUser();
  bool? first = SharedPreference.checkFirst();
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
          LoginScreen.routeName: (_) => LoginScreen(),
          ResetPassword.routeName: (_) => ResetPassword(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ForgetPassword.routeName: (_) => ForgetPassword(),
          OnboardingScreen.routeName: (_) => OnboardingScreen(),
          UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
          MovieDetails.routeName:(_)=> MovieDetails()
        },
        initialRoute: 
            first == false
                ? OnboardingScreen.routeName 
                : token == null
                ? LoginScreen.routeName
                : HomeScreen.routeName,
      ),
    );
  }
}
