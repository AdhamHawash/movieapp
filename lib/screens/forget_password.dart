import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  static const String routeName = "forgetPassword";
  static const Color bg = Colors.black;
  static const Color accent = Color(0xFFF6BD00);
  static const Color fieldBg = Color(0xFF282A28);
  static const Color hint = Colors.white;

  const ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.amber),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      'Forget Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
              SizedBox(height: 16.h),
              Center(
                child: Image.asset(
                  'assets/images/forget_password.png',
                  height: 430.h,
                  width: 430.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                decoration: BoxDecoration(
                  color: fieldBg,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: hint,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(Icons.mail_rounded, color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 55.72.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    textStyle: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  child: Text('Verify Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
