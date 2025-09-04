import 'package:flutter/material.dart';
import 'package:movieapp/register_screen.dart';

void main() {
  runApp( movieApp());
}

class movieApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {RegisterScreen.routeName: (_) => RegisterScreen()},
      initialRoute: RegisterScreen.routeName,
    );
  }
}