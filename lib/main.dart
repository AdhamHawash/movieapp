import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/login_screen.dart';
import 'package:movieapp/register_screen.dart';

void main() {
  runApp(movieApp());
}

class movieApp extends StatelessWidget {
  const movieApp({super.key});

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
        },
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
