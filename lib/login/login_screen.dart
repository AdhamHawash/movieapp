import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/login/login_view_model.dart';
import 'package:movieapp/register/register_screen.dart';
import 'package:movieapp/reset_password/reset_password.dart';
import 'package:movieapp/states.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hideText = false;

  List<bool> selected = [true, false];

  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginViewModel,
      child: BlocListener<LoginViewModel, States>(
        listener: (BuildContext context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => const AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("Loading..."),
                      ],
                    ),
                  ),
            );
          }
          if (state is ErrorState) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => AlertDialog(
                    content: Text("Error"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
            );
          }
          if (state is SucessState) {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xff121312),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 26.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 64.w),
                      child: Image.asset("assets/images/splash.png"),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 22.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              final RegExp emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else if (!emailRegex.hasMatch(value)) {
                                return "Enter a valied Email";
                              }
                              return null;
                            },
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xff282A28),
                              hintText: "Email",
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            obscureText: hideText,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: Color(0xff282A28),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xff282A28),

                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 26.r,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hideText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 26.r,
                                ),
                                onPressed: () {
                                  if (hideText == false) {
                                    hideText = true;
                                  } else {
                                    hideText = false;
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                ResetPassword.routeName,
                              );
                            },
                            child: Text(
                              "Forget Password?",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                color: Color(0xffF6BD00),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF6BD00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginViewModel.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Text(
                                "Login",
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  height: 1.2.h,
                                  color: Color(0xff282A28),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't Have Account ? ",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RegisterScreen.routeName,
                                    );
                                  },
                            text: "Create One",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Color(0xffF6BD00),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 76.w,
                            endIndent: 12.w,
                            color: Color(0xffF6BD00),
                            height: 1.h,
                          ),
                        ),
                        Text(
                          "OR",
                          style: GoogleFonts.roboto(
                            color: Color(0xffF6BD00),
                            fontSize: 16.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 12.w,
                            endIndent: 76.w,
                            color: Color(0xffF6BD00),
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffF6BD00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            child: Image.asset("assets/images/google.png"),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Login With Google",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              height: 1.2.h,
                              color: Color(0xff282A28),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ToggleButtons(
                      borderColor: Color(0xffF6BD00),
                      borderRadius: BorderRadius.circular(24.r),
                      selectedBorderColor: Color(0xffF6BD00),
                      fillColor: Color(0xffF6BD00),
                      isSelected: selected,
                      onPressed: (index) {
                        if (index == 0) {
                          selected[0] = true;
                          selected[1] = false;
                        } else {
                          selected[1] = true;
                          selected[0] = false;
                        }
                        setState(() {});
                      },
                      constraints: BoxConstraints(
                        minHeight: 40.h,
                        minWidth: 40.h,
                      ),
                      children: [
                        Image.asset("assets/images/en.png", fit: BoxFit.cover),
                        Image.asset("assets/images/ar.png", fit: BoxFit.cover),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
