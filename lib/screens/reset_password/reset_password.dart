// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/screens/login/login_screen.dart';
import 'package:movieapp/screens/reset_password/reset_password_view_model.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = "resetPassword";
  static const Color bg = Colors.black;
  static const Color accent = Color(0xFFF6BD00);
  static const Color fieldBg = Color(0xFF282A28);
  static const Color hint = Colors.white; 

  var formKey = GlobalKey<FormState>();

  TextEditingController currentPassController = TextEditingController();

  TextEditingController newPassController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  ResetPasswordViewModel resetPasswordViewModel = ResetPasswordViewModel();

  ResetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetPasswordViewModel,
      child: BlocListener<ResetPasswordViewModel, States>(
        listener: (context, state) {
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
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        },
        child: Scaffold(
          backgroundColor: bg,
          appBar: AppBar(
            backgroundColor: bg,
            title: Text(
              'Reset password',
              style: GoogleFonts.roboto(
                color: Color(0xffF6BD00),
                height: 1.2.h,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 12.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: TextFormField(
                              controller: currentPassController,
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
                                labelText: "Current password",
                                floatingLabelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: TextFormField(
                              controller: newPassController,
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
                                labelText: "New password",
                                floatingLabelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: TextFormField(
                              controller: confirmPassController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                } else if (newPassController.text !=
                                    confirmPassController.text) {
                                  return "password ddoesn't match";
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
                                labelText: "Confirm password",
                                floatingLabelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF6BD00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                resetPasswordViewModel.resetPassword(
                                  currentPassController.text,
                                  newPassController.text,
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
