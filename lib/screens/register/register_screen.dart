import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:movieapp/screens/login/login_screen.dart';
import 'package:movieapp/screens/register/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hideText = true;
  bool reHideText = true;

  List<bool> selected = [true, false];

  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int selectedAvatar = 0;

  List<String> avatars = [
    "assets/images/avatar1.png",
    "assets/images/avatar2.png",
    "assets/images/avatar3.png",
    "assets/images/avatar4.png",
    "assets/images/avatar5.png",
    "assets/images/avatar6.png",
    "assets/images/avatar7.png",
    "assets/images/avatar8.png",
    "assets/images/avatar9.png",
  ];

  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.r),
    borderSide: BorderSide(color: Color(0xff282A28)),
  );

  TextStyle fontStyle = GoogleFonts.roboto(
    fontSize: 16.sp,
    color: Colors.white,
  );

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => viewModel,
      child: BlocListener<RegisterViewModel, States>(
        listener: (BuildContext context, state) {
          if (state is LoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16.w),
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
                    title: Text("Error"),
                    content: Text(state.message),
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
          appBar: AppBar(
            backgroundColor: Color(0xff121312),
            leading: Icon(Icons.arrow_back, color: Color(0xffF6BD00)),
            title: Text(
              "Register",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                height: 1.2.h,
                color: Color(0xffF6BD00),
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Color(0xff121312),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 26.h,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160.0.h,
                        enlargeCenterPage: true,
                        viewportFraction: 0.4.w,
                      ),
                      items: [
                        for (var i = 0; i < 9; i++)
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(avatars[i]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "Avatar",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        height: 1.2.h,
                        color: Colors.white,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: 22.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            style: fontStyle,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              filled: true,
                              fillColor: Color(0xff282A28),
                              hintText: "Name",
                              hintStyle: fontStyle,
                              prefixIcon: Icon(
                                Icons.perm_identity_rounded,
                                color: Colors.white,
                                size: 26.sp,
                              ),
                            ),
                          ),
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
                            style: fontStyle,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              filled: true,
                              fillColor: Color(0xff282A28),
                              hintText: "Email",
                              hintStyle: fontStyle,
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
                            style: fontStyle,
                            obscureText: hideText,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              filled: true,
                              fillColor: Color(0xff282A28),

                              hintStyle: fontStyle,
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
                          TextFormField(
                            controller: confirmPassController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            style: fontStyle,
                            obscureText: reHideText,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              filled: true,
                              fillColor: Color(0xff282A28),

                              hintStyle: fontStyle,
                              hintText: "Confirm Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 26.r,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  reHideText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: 26.r,
                                ),
                                onPressed: () {
                                  if (reHideText == false) {
                                    reHideText = true;
                                  } else {
                                    reHideText = false;
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            style: fontStyle,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              filled: true,
                              fillColor: Color(0xff282A28),
                              hintText: "phone",
                              hintStyle: fontStyle,
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 26.sp,
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
                                User user = User(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  avaterId: selectedAvatar,
                                );
                                viewModel.register(user);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Text(
                                "Create Account",
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
                            text: "Already Have Account ? ",
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
                                      LoginScreen.routeName,
                                    );
                                  },
                            text: "Login",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Color(0xffF6BD00),
                              fontWeight: FontWeight.w900,
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
